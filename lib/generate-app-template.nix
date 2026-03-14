# Helm app-template JSON Schema → openkrill Nix module generator
#
# Takes a pre-resolved JSON schema (all $ref inlined) for the bjw-s
# app-template chart and emits a string of valid Nix source code
# defining typed submodules for chart values.
#
# The output is a library module (modules/lib/app-template.nix) that
# exports `valuesType` — a `types.submodule` consumers use in place
# of `types.attrs` for their `values` option.
{ lib }:
with lib;
let
  # ── String builder helpers ──────────────────────────────────────

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

  # Sentinel value meaning "no default specified"
  noDefault = { _noDefault = true; };
  hasDefault = d: !(isAttrs d && d ? _noDefault && d._noDefault);

  mkOptionStr = { type, description ? "", default ? noDefault }:
    removeEmptyLines ''
      mkOption {
        ${optionalString (description != "") "description = ${builtins.toJSON description};"}
        type = ${type};
        ${optionalString (hasDefault default) "default = ${toNixString default};"}
      }
    '';

  # ── Naming helpers ──────────────────────────────────────────────

  capitalize = s:
    let chars = stringToCharacters s;
    in concatStrings ([ (toUpper (head chars)) ] ++ (tail chars));

  # Sanitize names: remove hyphens, dots, etc. and camelCase
  sanitizePart = s:
    let
      parts = splitString "-" s;
      parts2 = concatLists (map (p: splitString "." p) parts);
    in concatStrings (map capitalize parts2);

  pathToModName = path: concatStrings (map sanitizePart path) + "Module";

  singularize = s:
    let chars = stringToCharacters s;
    in if lib.last chars == "s" && length chars > 1
       then concatStrings (lib.init chars)
       else s;

  # ── Schema classification ───────────────────────────────────────

  # Get the effective type from a schema, handling type arrays
  getType = schema:
    let rawType = schema.type or null;
    in if isList rawType then
      # Filter out "null" to find the real type
      let nonNull = filter (t: t != "null") rawType;
      in if length nonNull == 1 then head nonNull
         else if length nonNull == 0 then "null"
         else null  # multiple non-null types → union
    else rawType;

  isNullable = schema:
    let rawType = schema.type or null;
    in if isList rawType then elem "null" rawType
    else false;

  isObjectWithProps = schema:
    getType schema == "object" && hasAttr "properties" schema;

  isArrayOfObjects = schema:
    getType schema == "array" && hasAttr "items" schema
    && isObjectWithProps (schema.items);

  # Dictionary-of-submodules: object with additionalProperties that is an object with properties
  # OR additionalProperties that has allOf merging to an object with properties.
  isDictOfObjects = schema:
    let
      ap = schema.additionalProperties or null;
      resolvedAp = if isAttrs ap && hasAllOf ap then mergeAllOf ap else ap;
    in
    getType schema == "object"
    && !(hasAttr "properties" schema)
    && isAttrs ap
    && (isObjectWithProps resolvedAp || hasAllOf ap);

  hasAllOf = schema: hasAttr "allOf" schema;
  hasOneOf = schema: hasAttr "oneOf" schema;
  hasAnyOf = schema: hasAttr "anyOf" schema;

  # additionalProperties can be boolean `false` in JSON Schema (meaning "no extra props")
  hasRealAdditionalProperties = schema:
    hasAttr "additionalProperties" schema && isAttrs (schema.additionalProperties);

  isPassthrough = schema:
    (hasOneOf schema) || (hasAnyOf schema)
    || (getType schema == "object" && !(hasAttr "properties" schema) && !(hasRealAdditionalProperties schema));

  # ── allOf merger ────────────────────────────────────────────────
  # Merge an allOf array into a single combined schema by merging
  # properties from all items.

  mergeAllOf = schema:
    let
      items = schema.allOf or [];
      base = removeAttrs schema [ "allOf" ];
      merged = foldl' (acc: item:
        let
          resolved = if hasAllOf item then mergeAllOf item else item;
        in acc // {
          properties = (acc.properties or {}) // (resolved.properties or {});
          required = (acc.required or []) ++ (resolved.required or []);
        } // (optionalAttrs (hasAttr "type" resolved && !(hasAttr "type" acc)) { type = resolved.type; })
          // (optionalAttrs (hasAttr "description" resolved && !(hasAttr "description" acc)) { description = resolved.description; })
          // (optionalAttrs (hasRealAdditionalProperties resolved && !(hasRealAdditionalProperties acc)) { additionalProperties = resolved.additionalProperties; })
      ) base items;
    in merged;

  # ── Type mapping ────────────────────────────────────────────────

  mapScalarType = schema:
    let
      effectiveType = getType schema;
      nullable = isNullable schema;
    in
    if hasAttr "enum" schema then
      "(types.enum [ ${concatMapStringsSep " " toNixString schema.enum} ])"
    else if hasAttr "const" schema then
      "(types.enum [ ${toNixString schema.const} ])"
    else if effectiveType == null && hasOneOf schema then
      # Simple oneOf: check if it's a 2-variant scalar union
      let variants = schema.oneOf;
      in if length variants == 2 then
        let
          t1 = getType (head variants);
          t2 = getType (elemAt variants 1);
        in
        if t1 == "string" && t2 == "number" then "(types.either types.str types.number)"
        else if t1 == "string" && t2 == "integer" then "(types.either types.str types.int)"
        else if t1 == "number" && t2 == "string" then "(types.either types.number types.str)"
        else if t1 == "integer" && t2 == "string" then "(types.either types.int types.str)"
        else "types.anything"
      else "types.anything"
    else if effectiveType == null then "types.anything"
    else if effectiveType == "string" then
      if nullable then "(types.nullOr types.str)" else "types.str"
    else if effectiveType == "integer" || effectiveType == "number" then
      if nullable then "(types.nullOr types.int)" else "types.int"
    else if effectiveType == "boolean" then
      if nullable then "(types.nullOr types.bool)" else "types.bool"
    else if effectiveType == "array" then
      if hasAttr "items" schema
      then "(types.listOf ${mapScalarType schema.items})"
      else "(types.listOf types.anything)"
    else if effectiveType == "object" && hasRealAdditionalProperties schema then
      let innerType = mapScalarType schema.additionalProperties;
      in "(types.attrsOf ${innerType})"
    else "(types.attrsOf types.anything)";

  # ── Recursive walker ────────────────────────────────────────────
  # Returns { defs, optionLines } where:
  #   defs        - list of { name, value } for submodule definitions
  #   optionLines - list of strings: option declarations

  walkFields = { properties, required ? [], path, depth ? 0 }:
    let
      fieldNames = attrNames properties;
      results = map (fieldName:
        walkField {
          name = fieldName;
          schema = properties.${fieldName};
          isRequired = elem fieldName required;
          inherit path depth;
        }
      ) fieldNames;
    in {
      defs = concatLists (map (r: r.defs) results);
      optionLines = map (r: r.optionLine) results;
    };

  # Maximum recursion depth to prevent infinite loops
  maxDepth = 12;

  walkField = { name, schema, isRequired, path, depth ? 0 }:
    let
      # Pre-process: merge allOf if present
      resolved =
        if hasAllOf schema then mergeAllOf schema
        else schema;
    in
    if depth > maxDepth then
      # Safety valve: too deep, emit passthrough
      walkScalarField { inherit name isRequired path; schema = resolved // { type = "object"; }; }
    else if isObjectWithProps resolved then
      walkObjectField { inherit name isRequired path depth; schema = resolved; }
    else if isDictOfObjects resolved then
      walkDictField { inherit name isRequired path depth; schema = resolved; }
    else if isArrayOfObjects resolved then
      walkArrayField { inherit name isRequired path depth; schema = resolved; }
    else
      walkScalarField { inherit name isRequired path; schema = resolved; };

  walkScalarField = { name, schema, isRequired, path }:
    let
      effectiveType = getType schema;
      nullable = isNullable schema;
      isBool = effectiveType == "boolean" && !nullable;
      isList = effectiveType == "array";
      isMap = effectiveType == "object" && !(hasAttr "properties" schema);
      hasConst = hasAttr "const" schema;
      hasEnum = hasAttr "enum" schema;

      baseType = mapScalarType schema;

      # Determine whether to wrap in nullOr
      # When the default would be null, wrap the type in nullOr so null is valid
      type =
        if isRequired then baseType
        else if hasConst then baseType
        else if hasEnum then baseType
        else if isBool then baseType
        else if isList then baseType
        else if isMap then baseType
        else if isPassthrough schema then baseType
        else if nullable then baseType  # already nullOr from mapScalarType
        else "(types.nullOr ${baseType})";

      default =
        if isRequired then noDefault
        else if hasConst then schema.const
        else if hasAttr "default" schema then schema.default
        else if isBool then false
        else if isList then []
        else if isMap then {}
        else if isPassthrough schema then {}
        else if hasEnum then noDefault
        else null;

      description = schema.description or "";

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';
    in {
      defs = [];
      inherit optionLine;
    };

  walkObjectField = { name, schema, isRequired, path, depth ? 0 }:
    let
      fullPath = path ++ [ name ];
      modName = pathToModName fullPath;
      required = schema.required or [];
      walked = walkFields {
        properties = schema.properties;
        inherit required;
        path = fullPath;
        depth = depth + 1;
      };
      description = schema.description or "";

      type = if isRequired then modName else "(types.nullOr ${modName})";
      default =
        if isRequired then noDefault
        else if hasAttr "default" schema then schema.default
        else null;

      defBody = ''
        ${modName} = types.submodule {
          freeformType = types.attrsOf types.anything;
          options = {
            ${concatStringsSep "\n" walked.optionLines}
          };
        };
      '';

      defs = walked.defs ++ [{ name = modName; value = defBody; }];

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';
    in {
      inherit defs optionLine;
    };

  # Dictionary of submodules: object with additionalProperties being an object
  # E.g. controllers, service, persistence — these are `attrsOf <submodule>`
  walkDictField = { name, schema, isRequired, path, depth ? 0 }:
    let
      itemName = singularize name;
      itemPath = path ++ [ itemName ];
      modName = pathToModName itemPath;
      rawAp = schema.additionalProperties;
      itemSchema = if hasAllOf rawAp then mergeAllOf rawAp else rawAp;
      required = itemSchema.required or [];
      walked = walkFields {
        properties = itemSchema.properties or {};
        inherit required;
        path = itemPath;
        depth = depth + 1;
      };
      description = schema.description or "";

      type = "(types.attrsOf ${modName})";
      default = {};

      defBody = ''
        ${modName} = types.submodule {
          freeformType = types.attrsOf types.anything;
          options = {
            ${concatStringsSep "\n" walked.optionLines}
          };
        };
      '';

      defs = walked.defs ++ [{ name = modName; value = defBody; }];

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';
    in {
      inherit defs optionLine;
    };

  walkArrayField = { name, schema, isRequired, path, depth ? 0 }:
    let
      itemName = singularize name;
      itemPath = path ++ [ itemName ];
      modName = pathToModName itemPath;
      itemSchema = schema.items;
      required = itemSchema.required or [];
      walked = walkFields {
        properties = itemSchema.properties;
        inherit required;
        path = itemPath;
        depth = depth + 1;
      };
      description = schema.description or "";

      type = "(types.listOf ${modName})";
      default = if isRequired then noDefault else [];

      defBody = ''
        ${modName} = types.submodule {
          freeformType = types.attrsOf types.anything;
          options = {
            ${concatStringsSep "\n" walked.optionLines}
          };
        };
      '';

      defs = walked.defs ++ [{ name = modName; value = defBody; }];

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';
    in {
      inherit defs optionLine;
    };

  # ── Top-level assembly ──────────────────────────────────────────

  generateModule = { schema }:
    let
      # The root schema has .properties with the top-level chart values
      rootProps = schema.properties or {};
      required = schema.required or [];

      # Walk each top-level property
      walked = walkFields {
        properties = rootProps;
        inherit required;
        path = [];
      };

      # Deduplicate submodule definitions by name (keep first occurrence)
      allDefs = walked.defs;
      letDefs = concatStrings (attrValues (listToAttrs allDefs));

    in removeEmptyLines ''
      # Auto-generated typed options for the bjw-s app-template Helm chart.
      # Generated from lib/helm-app-schema/values.schema.json.
      # See specs/nix-module-app-generator.md for the generator pattern.
      #
      # DO NOT EDIT — regenerate with: bin/create-module-app-template
      { lib }:
      with lib;
      let
        ${letDefs}
      in
      {
        valuesType = types.submodule {
          freeformType = types.attrsOf types.anything;
          options = {
            ${concatStringsSep "\n" walked.optionLines}
          };
        };
      }
    '';

in {
  inherit generateModule;
}
