# lib/k8s.nix — Kubernetes resource helpers
{ pkgs }:
rec {
  # ── mkNamespace ────────────────────────────────────────────────────────
  mkNamespace = name: {
    apiVersion = "v1";
    kind = "Namespace";
    metadata = { inherit name; };
  };

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
