# Central registry of all openkrill app modules.
# App modules live in ../apps/{stable,unstable}/<name>/ and are discovered
# automatically via readDir. Each module should use mkEnableOption so it's
# disabled by default.
let
  appsDir = ../apps;
  tiers = [ "stable" "unstable" ];
  discoverTier = tier:
    let
      tierDir = appsDir + "/${tier}";
      entries = builtins.readDir tierDir;
      appNames = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
    in
    map (name: tierDir + "/${name}") appNames;
in
builtins.concatLists (map discoverTier tiers)
