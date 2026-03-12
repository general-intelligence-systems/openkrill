# CRD-to-openkrill-module generator
#
# Takes a list of parsed CRD JSON objects and a module name,
# returns a string of valid Nix source code for a complete openkrill module.
{ lib }:
with lib;
let
  # ── String builder helpers (adapted from kubenix) ────────────────

  toNixString = value:
    if isList value then
      "[ ${concatMapStringsSep " " toNixString value} ]"
    else if isAttrs value then
      "{ ${concatStringsSep " " (mapAttrsToList (k: v: ''"${k}" = ${toNixString v};'') value)} }"
    else if isString value then ''"${value}"''
    else if value == null then "null"
    else if isBool value then (if value then "true" else "false")
    else builtins.toString value;

  removeEmptyLines = str:
    concatStringsSep "\n" (filter (l: builtins.match "[[:space:]]*" l != [ ]) (splitString "\n" str));

  # Sentinel value meaning "no default specified" (distinct from null)
  noDefault = { _noDefault = true; };
  hasDefault = d: !(isAttrs d && d._noDefault or false);

  mkOptionStr = { type, description ? "", default ? noDefault }:
    removeEmptyLines ''
      mkOption {
        ${optionalString (description != "") "description = ${builtins.toJSON description};"}
        type = ${type};
        ${optionalString (hasDefault default) "default = ${toNixString default};"}
      }
    '';

  # ── Naming helpers ───────────────────────────────────────────────

  capitalize = s:
    let chars = stringToCharacters s;
    in concatStrings ([ (toUpper (head chars)) ] ++ (tail chars));

  pathToModName = path: concatStrings (map capitalize path) + "Module";
  pathToBuilderName = path: "mk" + concatStrings (map capitalize path);

  singularize = s:
    let chars = stringToCharacters s;
    in if lib.last chars == "s" && length chars > 1
       then concatStrings (lib.init chars)
       else s;

  # ── Schema classification ────────────────────────────────────────

  isObjectWithProps = schema:
    (schema.type or "") == "object" && hasAttr "properties" schema;

  isArrayOfObjects = schema:
    (schema.type or "") == "array" && hasAttr "items" schema
    && isObjectWithProps (schema.items);

  isPassthrough = schema:
    (hasAttr "oneOf" schema) || (hasAttr "anyOf" schema)
    || ((schema.type or "") == "object" && !(hasAttr "properties" schema) && !(hasAttr "additionalProperties" schema));

  # ── Type mapping ─────────────────────────────────────────────────

  mapScalarType = schema:
    if hasAttr "enum" schema then
      "(types.enum [ ${concatMapStringsSep " " toNixString schema.enum} ])"
    else if !(hasAttr "type" schema) then "types.anything"
    else if schema.type == "string" then
      if (schema.format or "") == "int-or-string"
      then "(types.either types.int types.str)"
      else "types.str"
    else if schema.type == "integer" || schema.type == "number" then "types.int"
    else if schema.type == "boolean" then "types.bool"
    else if schema.type == "array" then
      if hasAttr "items" schema
      then "(types.listOf ${mapScalarType schema.items})"
      else "(types.listOf types.anything)"
    else if schema.type == "object" && hasAttr "additionalProperties" schema then
      "(types.attrsOf ${mapScalarType schema.additionalProperties})"
    else "(types.attrsOf types.anything)";

  # ── Recursive walker ─────────────────────────────────────────────
  # Returns an attrset with:
  #   defs     - string: submodule + builder definitions for the let block
  #   optionLines - list of strings: option declarations
  #   builderLines - list of strings: builder body lines (for the mk function)

  walkFields = { properties, required ? [], path }:
    let
      fieldNames = attrNames properties;
      results = map (fieldName:
        walkField {
          name = fieldName;
          schema = properties.${fieldName};
          isRequired = elem fieldName required;
          inherit path;
        }
      ) fieldNames;
    in {
      defs = concatLists (map (r: r.defs) results);
      optionLines = map (r: r.optionLine) results;
      builderLines = concatLists (map (r: r.builderLines) results);
    };

  walkField = { name, schema, isRequired, path }:
    if isObjectWithProps schema then walkObjectField { inherit name schema isRequired path; }
    else if isArrayOfObjects schema then walkArrayField { inherit name schema isRequired path; }
    else walkScalarField { inherit name schema isRequired path; };

  walkScalarField = { name, schema, isRequired, path }:
    let
      baseType = mapScalarType schema;
      isBool = (schema.type or "") == "boolean";
      isList = (schema.type or "") == "array";
      isMap = (schema.type or "") == "object" && !(hasAttr "properties" schema);
      hasEnum = hasAttr "enum" schema;
      type =
        if isRequired then baseType
        else if isBool then baseType
        else if isList then baseType
        else if isMap then baseType
        else if isPassthrough schema then baseType
        else "(types.nullOr ${baseType})";
      default =
        if isRequired then noDefault
        else if hasAttr "default" schema then schema.default
        else if isBool then false
        else if isList then []
        else if isMap then {}
        else if isPassthrough schema then {}
        else null;  # nullOr → null
      description = schema.description or "";

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';

      builderLines =
        if isRequired then
          [ ''inherit (res) "${name}";'' ]
        else if isBool && default == false then
          [ ''} // optionalAttrs res."${name}" { inherit (res) "${name}"; } // {'' ]
        else if isList then
          [ ''} // optionalAttrs (res."${name}" != []) { inherit (res) "${name}"; } // {'' ]
        else if isMap then
          [ ''} // optionalAttrs (res."${name}" != {}) { inherit (res) "${name}"; } // {'' ]
        else
          [ ''} // optionalAttrs (res."${name}" != null) { inherit (res) "${name}"; } // {'' ];
    in {
      defs = [];
      inherit optionLine builderLines;
    };

  walkObjectField = { name, schema, isRequired, path }:
    let
      fullPath = path ++ [ name ];
      modName = pathToModName fullPath;
      builderFn = pathToBuilderName fullPath;
      required = schema.required or [];
      walked = walkFields { properties = schema.properties; inherit required; path = fullPath; };
      description = schema.description or "";

      type = if isRequired then modName else "(types.nullOr ${modName})";
      default =
        if isRequired then noDefault
        else if hasAttr "default" schema then schema.default
        else null;

      defBody = ''
        ${modName} = types.submodule {
          options = {
            ${concatStringsSep "\n" walked.optionLines}
          };
        };
        ${builderFn} = res: {
          ${concatStringsSep "\n" walked.builderLines}
        };
      '';

      defs = walked.defs ++ [{ name = modName; value = defBody; }];

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';

      builderLines =
        if isRequired then
          [ ''"${name}" = ${builderFn} res."${name}";'' ]
        else
          [ ''} // optionalAttrs (res."${name}" != null) { "${name}" = ${builderFn} res."${name}"; } // {'' ];
    in {
      inherit defs optionLine builderLines;
    };

  walkArrayField = { name, schema, isRequired, path }:
    let
      itemName = singularize name;
      itemPath = path ++ [ itemName ];
      modName = pathToModName itemPath;
      builderFn = pathToBuilderName itemPath;
      itemSchema = schema.items;
      required = itemSchema.required or [];
      walked = walkFields { properties = itemSchema.properties; inherit required; path = itemPath; };
      description = schema.description or "";

      type = "(types.listOf ${modName})";
      default =
        if isRequired then noDefault
        else if hasAttr "default" schema then schema.default
        else [];

      defBody = ''
        ${modName} = types.submodule {
          options = {
            ${concatStringsSep "\n" walked.optionLines}
          };
        };
        ${builderFn} = res: {
          ${concatStringsSep "\n" walked.builderLines}
        };
      '';

      defs = walked.defs ++ [{ name = modName; value = defBody; }];

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';

      builderLines =
        if isRequired then
          [ ''"${name}" = map ${builderFn} res."${name}";'' ]
        else
          [ ''} // optionalAttrs (res."${name}" != []) { "${name}" = map ${builderFn} res."${name}"; } // {'' ];
    in {
      inherit defs optionLine builderLines;
    };

  # ── CRD info extraction ──────────────────────────────────────────

  extractCrdInfo = crd:
    let
      group = crd.spec.group;
      names = crd.spec.names;
      versions = crd.spec.versions;
      storedVersion = findFirst (v: v.storage or false) (head versions) versions;
      version = storedVersion.name;
      specSchema = storedVersion.schema.openAPIV3Schema.properties.spec;
    in {
      apiVersion = if group == "" then version else "${group}/${version}";
      kind = names.kind;
      plural = names.plural;
      inherit specSchema;
      description = storedVersion.schema.openAPIV3Schema.description or "${names.kind} resource";
    };

  # ── Top-level module assembly ────────────────────────────────────

  generateModule = { crds, moduleName, standalone ? true }:
    let
      perCrd = map (crd:
        let
          info = extractCrdInfo crd;
          specSchema = info.specSchema;
          required = specSchema.required or [];
          walked = walkFields {
            properties = specSchema.properties or {};
            inherit required;
            path = [];
          };
          topModName = pathToModName [ info.plural ];
          topBuilderFn = pathToBuilderName [ info.kind ];
        in {
          inherit info walked topModName topBuilderFn;
        }
      ) crds;

      # Submodule + builder definitions (in let block)
      # Deduplicate by name — listToAttrs keeps the first occurrence,
      # so shared types (e.g. ParentRefModule) emitted by multiple CRDs
      # are only included once.
      allDefs = concatLists (map (d: d.walked.defs) perCrd);
      letDefs = concatStrings (attrValues (listToAttrs allDefs));

      # Top-level submodule per CRD kind
      topSubmodules = concatStrings (map (d: ''
        ${d.topModName} = types.submodule ({ name, ... }: {
          options = {
            "namespace" = mkOption {
              type = types.str;
              description = "Namespace for this ${d.info.kind} resource.";
            };
            ${concatStringsSep "\n" d.walked.optionLines}
          };
        });
      '') perCrd);

      # Top-level builder per CRD kind
      topBuilders = concatStrings (map (d: ''
        ${d.topBuilderFn} = name: res: {
          apiVersion = "${d.info.apiVersion}";
          kind = "${d.info.kind}";
          metadata = {
            inherit name;
            namespace = res.namespace;
          };
          spec = {
            ${concatStringsSep "\n" d.walked.builderLines}
          };
        };
      '') perCrd);

      # Option declarations
      optionDecls = concatStrings (map (d: ''
        "${d.info.plural}" = mkOption {
          type = types.attrsOf ${d.topModName};
          default = {};
          description = "${d.info.kind} CRD instances.";
        };
      '') perCrd);

      # Resource list expression
      resourceExpr =
        if length perCrd == 1 then
          "(mapAttrsToList ${(head perCrd).topBuilderFn} cfg.\"${(head perCrd).info.plural}\")"
        else
          concatMapStringsSep "\n++ " (d:
            "(mapAttrsToList ${d.topBuilderFn} cfg.\"${d.info.plural}\")"
          ) perCrd;

    in removeEmptyLines (if standalone then ''
      # Auto-generated openkrill module for ${moduleName}
      # Generated from CRD specification. See specs/nix-module-crds.md.
      { config, lib, ... }:
      with lib;
      let
        cfg = config.openkrill.apps."${moduleName}";
        helpers = import ../../modules/lib/helpers.nix { inherit lib; };
        compact = filterAttrs (_: v: v != null);

        ${letDefs}

        ${topSubmodules}

        ${topBuilders}

        allResources = ${resourceExpr};
      in
      {
        options.openkrill.apps."${moduleName}" = {
          enable = mkEnableOption "${moduleName} CRD resources";

          ${optionDecls}

          extraManifests = helpers.mkExtraManifestsOption;
        };

        config = mkIf cfg.enable {
          openkrill.manifests."${moduleName}".content = allResources;
        };
      }
    '' else ''
      # Auto-generated openkrill module fragment for ${moduleName}
      # Generated from CRD specification. See specs/nix-module-crds.md.
      # This is a fragment — import from a composing module that declares
      # enable, extraManifests, and other shared options.
      { config, lib, ... }:
      with lib;
      let
        cfg = config.openkrill.apps."${moduleName}";
        compact = filterAttrs (_: v: v != null);

        ${letDefs}

        ${topSubmodules}

        ${topBuilders}

        allResources = ${resourceExpr};
      in
      {
        options.openkrill.apps."${moduleName}" = {
          ${optionDecls}
        };

        config = mkIf cfg.enable {
          openkrill.manifests."${moduleName}".content = allResources;
        };
      }
    '');

in {
  inherit generateModule;
}
