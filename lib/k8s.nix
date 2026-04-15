# lib/k8s.nix — Kubernetes resource helpers
{ pkgs }:
rec {
  # ── mkNamespace ────────────────────────────────────────────────────────
  mkNamespace = name: {
    apiVersion = "v1";
    kind = "Namespace";
    metadata = { inherit name; };
  };

  # ── fromYAML ──────────────────────────────────────────────────────────
  # Read a YAML file and return it as a Nix attrset (IFD via yq-go).
  fromYAML = file:
    builtins.fromJSON (builtins.readFile (pkgs.runCommand "yaml-to-json" {
      nativeBuildInputs = [ pkgs.yq-go ];
    } ''
      yq -o=json ${file} > $out
    ''));

  # ── mkSecret ───────────────────────────────────────────────────────────
  mkSecret =
    {
      name,
      namespace,
      stringData,
    }:
    {
      apiVersion = "v1";
      kind = "Secret";
      metadata = { inherit name namespace; };
      type = "Opaque";
      inherit stringData;
    };
}
