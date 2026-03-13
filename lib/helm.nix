# lib/helm.nix — Helm chart helpers
#
# Inlined from farcaller/nix-kube-generators to eliminate the external
# dependency.  Only the three functions actually used by openkrill are
# kept: fromYAML, buildHelmChart / fromHelm, and downloadHelmChart.
{ pkgs }:
rec {
  # ── fromYAML ──────────────────────────────────────────────────────────
  # Parse a multi-document YAML string into a list of Nix attrsets.
  fromYAML = yaml: pkgs.lib.pipe yaml [
    (yaml: (pkgs.stdenv.mkDerivation {
      inherit yaml;
      passAsFile = "yaml";
      name = "fromYAML";
      phases = [ "buildPhase" ];
      buildPhase = "${pkgs.yq}/bin/yq -Ms . $yamlPath > $out";
    }))
    builtins.readFile
    builtins.fromJSON
    (builtins.filter (v: v != null))
  ];

  # ── buildHelmChart ────────────────────────────────────────────────────
  # Run `helm template` on an extracted chart directory.
  # Returns a derivation whose output is the rendered YAML.
  buildHelmChart =
    { name
    , chart
    , namespace ? null
    , values ? {}
    , includeCRDs ? true
    , kubeVersion ? null
    , apiVersions ? []
    , extraOpts ? []
    }:
    let
      hasNamespace = !builtins.isNull namespace;
      helmNamespaceFlag = if hasNamespace then "--namespace ${namespace}" else "";
      namespaceName = if hasNamespace then "-${namespace}" else "";
      kubeVersionFlag = if kubeVersion != null then "--kube-version ${kubeVersion}" else "";
    in
    pkgs.stdenv.mkDerivation {
      name = "helm-${chart}${namespaceName}-${name}";

      passAsFile = [ "helmValues" ];
      helmValues = builtins.toJSON values;
      helmCRDs = if includeCRDs then "--include-crds" else "";

      phases = [ "installPhase" ];
      installPhase = ''
        export HELM_CACHE_HOME="$TMP/.nix-helm-build-cache"

        ${pkgs.kubernetes-helm}/bin/helm template \
        $helmCRDs \
        ${helmNamespaceFlag} \
        ${kubeVersionFlag} \
        --values "$helmValuesPath" \
        "${name}" \
        "${chart}" \
        ${builtins.concatStringsSep " " extraOpts} \
        ${builtins.concatStringsSep " " (map (v: "-a ${v}") apiVersions)} \
        >> $out
      '';
    };

  # ── fromHelm ──────────────────────────────────────────────────────────
  # Render a helm chart and parse the output into a list of Nix attrsets.
  # Accepts the same arguments as buildHelmChart.
  fromHelm = args: pkgs.lib.pipe args [ buildHelmChart builtins.readFile fromYAML ];

  # ── downloadHelmChart ─────────────────────────────────────────────────
  # Download and extract a helm chart as a fixed-output derivation.
  # Used for charts not tracked in nixhelm.
  downloadHelmChart = { repo, chart, version, chartHash ? pkgs.lib.fakeHash }:
    let
      pullFlags = if (pkgs.lib.hasPrefix "oci://" repo)
        then "${repo}/${chart}"
        else ''--repo "${repo}" "${chart}"'';
    in
    pkgs.stdenv.mkDerivation {
      name = "helm-chart-${chart}-${version}";
      nativeBuildInputs = [ pkgs.cacert ];

      phases = [ "installPhase" ];
      installPhase = ''
        export HELM_CACHE_HOME="$TMP/.nix-helm-build-cache"

        OUT_DIR="$TMP/temp-chart-output"
        mkdir -p "$OUT_DIR"

        ${pkgs.kubernetes-helm}/bin/helm pull \
        --version "${version}" \
        ${pullFlags} \
        -d $OUT_DIR \
        --untar

        mv $OUT_DIR/${chart} "$out"
      '';

      outputHashMode = "recursive";
      outputHashAlgo = "sha256";
      outputHash = chartHash;
    };
}
