# Central registry of all openkrill app modules.
# App modules live in ../apps/<name>/ and are discovered automatically
# via readDir. Each module should use mkEnableOption so it's disabled
# by default.
let
  appsDir = ../apps;
  entries = builtins.readDir appsDir;
  appNames = builtins.filter (name: entries.${name} == "directory") (builtins.attrNames entries);
in
map (name: appsDir + "/${name}") appNames
