# Helm values.schema.json → openkrill values.nix generator
#
# Takes a parsed JSON Schema object (from a Bitnami chart's values.schema.json)
# and generates a string of valid Nix source code for a types.submodule with
# freeformType, typed options, and schema defaults.
#
# The output is a values.nix file that can be imported by a composing module:
#   values = mkOption { type = types.submodule (import ./values.nix); default = {}; };
#
# See also: lib/generate-module.nix (CRD generator — same walker architecture)
{ lib }:
with lib;
let
  # ── String builder helpers (shared with CRD generator) ──────────

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
  hasDefault = d: !(isAttrs d && d._noDefault or false);

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

  # Sanitize field names for use in Nix identifiers (replace hyphens, dots)
  sanitize = s: replaceStrings [ "-" "." ] [ "_" "_" ] s;

  pathToModName = path: concatStrings (map (s: capitalize (sanitize s)) path) + "Module";

  singularize = s:
    let chars = stringToCharacters s;
    in if lib.last chars == "s" && length chars > 1
       then concatStrings (lib.init chars)
       else s;

  # ── Schema classification ───────────────────────────────────────

  # Bitnami schemas use union types like ["object", "string"] for
  # template-or-value fields. Normalize to a single type string.
  getType = schema:
    let t = schema.type or "";
    in if isList t then
      # Union type — pick the most structured type, or fall back to "anything"
      if elem "object" t then "object"
      else if elem "array" t then "array"
      else "anything"
    else t;

  isObjectWithProps = schema:
    getType schema == "object" && hasAttr "properties" schema;

  isArrayOfObjects = schema:
    getType schema == "array" && hasAttr "items" schema
    && isObjectWithProps (schema.items);

  isUnionType = schema:
    isList (schema.type or "");

  # ── Type mapping ────────────────────────────────────────────────

  mapScalarType = schema:
    let t = getType schema;
    in
    if isUnionType schema then "types.anything"
    else if hasAttr "enum" schema then
      "(types.enum [ ${concatMapStringsSep " " toNixString schema.enum} ])"
    else if t == "" || t == "anything" then "types.anything"
    else if t == "string" then "types.str"
    else if t == "integer" || t == "number" then "types.int"
    else if t == "boolean" then "types.bool"
    else if t == "array" then
      if hasAttr "items" schema && hasAttr "type" schema.items
      then "(types.listOf ${mapScalarType schema.items})"
      else "(types.listOf types.anything)"
    else if t == "object" && hasAttr "additionalProperties" schema then
      "(types.attrsOf ${mapScalarType schema.additionalProperties})"
    else if t == "object" then "(types.attrsOf types.anything)"
    else "types.anything";

  # ── Recursive walker ────────────────────────────────────────────
  # Returns:
  #   defs        - list of { name, value } for submodule type definitions
  #   optionLines - list of strings: option declarations

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
    };

  walkField = { name, schema, isRequired, path }:
    if isObjectWithProps schema then walkObjectField { inherit name schema isRequired path; }
    else if isArrayOfObjects schema then walkArrayField { inherit name schema isRequired path; }
    else walkScalarField { inherit name schema isRequired path; };

  walkScalarField = { name, schema, isRequired, path }:
    let
      baseType = mapScalarType schema;
      t = getType schema;
      isBool = t == "boolean";
      isList' = t == "array";
      isMap = t == "object" && !(hasAttr "properties" schema);
      isUnion = isUnionType schema;
      type =
        if isRequired then baseType
        else if isBool then baseType
        else if isList' then baseType
        else if isMap then baseType
        else if isUnion then baseType
        else "(types.nullOr ${baseType})";
      default =
        if hasAttr "default" schema then schema.default
        else if isRequired then noDefault
        else if isBool then false
        else if isList' then []
        else if isMap then {}
        else if isUnion then noDefault
        else null;
      description = schema.description or "";

      optionLine = ''"${name}" = ${mkOptionStr { inherit type description default; }};'';
    in {
      defs = [];
      inherit optionLine;
    };

  walkObjectField = { name, schema, isRequired, path }:
    let
      fullPath = path ++ [ name ];
      modName = pathToModName fullPath;
      required = schema.required or [];
      walked = walkFields { properties = schema.properties; inherit required; path = fullPath; };
      description = schema.description or "";

      type = modName;
      default = if hasAttr "default" schema then schema.default else {};

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

  walkArrayField = { name, schema, isRequired, path }:
    let
      itemName = singularize name;
      itemPath = path ++ [ itemName ];
      modName = pathToModName itemPath;
      itemSchema = schema.items;
      required = itemSchema.required or [];
      walked = walkFields { properties = itemSchema.properties; inherit required; path = itemPath; };
      description = schema.description or "";

      type = "(types.listOf ${modName})";
      default = if hasAttr "default" schema then schema.default else [];

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

  generateValuesModule = { schema }:
    let
      properties = schema.properties or {};
      required = schema.required or [];
      walked = walkFields { inherit properties required; path = []; };

      # Deduplicate submodule defs by name
      allDefs = walked.defs;
      letDefs = concatStrings (attrValues (listToAttrs allDefs));
    in removeEmptyLines ''
      # Auto-generated from Bitnami values.schema.json
      # Do not edit — regenerate with bin/create-module-bitnami
      { lib, ... }:
      with lib;
      let
        ${letDefs}
      in
      {
        freeformType = types.attrsOf types.anything;
        options = {
          ${concatStringsSep "\n" walked.optionLines}
        };
      }
    '';

in {
  inherit generateValuesModule;
}
