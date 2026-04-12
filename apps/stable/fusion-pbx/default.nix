# apps/stable/fusion-pbx — FusionPBX VoIP PBX on KubeVirt
#
# Deploys FusionPBX as a KubeVirt VirtualMachine running Debian 12
# with FreeSWITCH, PostgreSQL, NGINX, PHP-FPM, and Fail2ban.
#
# The VM uses bridge networking so SIP/RTP UDP traffic flows directly
# without NAT — critical for VoIP quality.
#
# The `clusterNodes` option taints the target node(s) with
#   fusionpbx=dedicated:NoSchedule
# so that only the FusionPBX VM is scheduled there, giving it
# exclusive use of the host network stack for UDP port ranges.
# Since the node is dedicated, the VM gets all available CPU/RAM
# and storage uses local-path on the node's disk.
#
# Networking:
#   Web UI  — ClusterIP Service + HTTPRoute through Traefik (pbx.<domain>)
#   SIP     — LoadBalancer Service on dedicated node (5060, 5080 TCP+UDP)
#   RTP     — LoadBalancer Service on dedicated node (configurable narrow
#             UDP port range, default 16384–16483 = 100 ports ≈ 50 calls)
#
# FreeSWITCH's RTP range is narrowed via cloud-init to match the Service
# definition, since K8s Services cannot express port ranges.
{ config, lib, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.fusion-pbx;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };

  rtpPortCount = cfg.rtpPortRange.end - cfg.rtpPortRange.start;

  # ── Node taint resources ───────────────────────────────────────
  # A Job that taints + labels the target node(s) so only pods with
  # the matching toleration (i.e. the FusionPBX VM) can schedule there.
  taintResources = [
    {
      apiVersion = "v1";
      kind = "ServiceAccount";
      metadata = { name = "fusion-pbx-taint-manager"; namespace = cfg.namespace; };
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRole";
      metadata.name = "fusion-pbx-taint-manager";
      rules = [{
        apiGroups = [ "" ];
        resources = [ "nodes" ];
        verbs = [ "get" "patch" ];
      }];
    }
    {
      apiVersion = "rbac.authorization.k8s.io/v1";
      kind = "ClusterRoleBinding";
      metadata.name = "fusion-pbx-taint-manager";
      roleRef = {
        apiGroup = "rbac.authorization.k8s.io";
        kind = "ClusterRole";
        name = "fusion-pbx-taint-manager";
      };
      subjects = [{
        kind = "ServiceAccount";
        name = "fusion-pbx-taint-manager";
        namespace = cfg.namespace;
      }];
    }
    {
      apiVersion = "batch/v1";
      kind = "Job";
      metadata = { name = "fusion-pbx-taint-node"; namespace = cfg.namespace; };
      spec = {
        backoffLimit = 5;
        template = {
          metadata.labels."app.kubernetes.io/name" = "fusion-pbx-taint-node";
          spec = {
            serviceAccountName = "fusion-pbx-taint-manager";
            restartPolicy = "OnFailure";
            containers = [{
              name = "taint";
              image = "bitnami/kubectl:latest";
              command = [ "sh" "-c" ''
                for NODE in ${concatStringsSep " " cfg.clusterNodes}; do
                  echo "Tainting node $NODE ..."
                  kubectl taint nodes "$NODE" fusionpbx=dedicated:NoSchedule --overwrite
                  kubectl label nodes "$NODE" fusionpbx-dedicated=true --overwrite
                done
              '' ];
            }];
          };
        };
      };
    }
  ];

  # ── FusionPBX VirtualMachine CR ────────────────────────────────
  vmResource = {
    apiVersion = "kubevirt.io/v1";
    kind = "VirtualMachine";
    metadata = { name = cfg.vmName; namespace = cfg.namespace; };
    spec = {
      running = true;
      template = {
        metadata.labels = {
          "app.kubernetes.io/name" = "fusion-pbx";
          "kubevirt.io/vm" = cfg.vmName;
        };
        spec = {
          # Pin to tainted node(s) and tolerate the taint
          nodeSelector = { "fusionpbx-dedicated" = "true"; };
          tolerations = [{
            key = "fusionpbx";
            operator = "Equal";
            value = "dedicated";
            effect = "NoSchedule";
          }];

          domain = {
            cpu.cores = cfg.cpu;
            resources.requests.memory = cfg.memory;
            devices = {
              disks = [
                { name = "rootdisk"; disk.bus = "virtio"; }
                { name = "datadisk"; disk.bus = "virtio"; }
                { name = "cloudinit"; disk.bus = "virtio"; }
              ];
              interfaces = [{
                name = "default";
                bridge = {};
              }];
            };
          };

          networks = [{
            name = "default";
            pod = {};
          }];

          volumes = [
            {
              name = "rootdisk";
              containerDisk.image = cfg.image;
            }
            {
              name = "datadisk";
              persistentVolumeClaim.claimName = "${cfg.vmName}-data";
            }
            {
              name = "cloudinit";
              cloudInitNoCloud.userData = concatStringsSep "\n" ([
                "#cloud-config"
                "package_update: true"
                "package_upgrade: true"
                "packages:"
                "  - wget"
                "  - ca-certificates"
                "runcmd:"
                # FusionPBX quick install from official docs
                "  - 'wget -O - https://raw.githubusercontent.com/fusionpbx/fusionpbx-install.sh/master/debian/pre-install.sh | sh'"
                "  - 'cd /usr/src/fusionpbx-install.sh/debian && ./install.sh'"
                # Narrow FreeSWITCH RTP port range to match the K8s Service definition
                "  - \"sed -i 's/16384/${toString cfg.rtpPortRange.start}/' /etc/freeswitch/autoload_configs/switch.conf.xml\""
                "  - \"sed -i 's/32768/${toString (cfg.rtpPortRange.end - 1)}/' /etc/freeswitch/autoload_configs/switch.conf.xml\""
                "  - 'systemctl restart freeswitch || true'"
              ] ++ optionals (cfg.sshAuthorizedKeys != []) [
                "users:"
                "  - name: root"
                "    ssh_authorized_keys:"
              ] ++ map (k: "      - ${builtins.toJSON k}") cfg.sshAuthorizedKeys);
            }
          ];
        };
      };
    };
  };

  # ── Local-path PVC for VM data ─────────────────────────────────
  dataPVC = {
    apiVersion = "v1";
    kind = "PersistentVolumeClaim";
    metadata = { name = "${cfg.vmName}-data"; namespace = cfg.namespace; };
    spec = {
      accessModes = [ "ReadWriteOnce" ];
      storageClassName = "local-path";
      resources.requests.storage = cfg.dataSize;
    };
  };

  # ── ClusterIP Service for Web UI (fronted by Traefik HTTPRoute) ─
  webService = {
    apiVersion = "v1";
    kind = "Service";
    metadata = { name = "${cfg.vmName}-web"; namespace = cfg.namespace; };
    spec = {
      selector."kubevirt.io/vm" = cfg.vmName;
      ports = [{
        name = "http";
        port = 80;
        targetPort = 80;
        protocol = "TCP";
      }];
    };
  };

  # ── LoadBalancer Service for SIP signalling ─────────────────────
  # Pinned to the dedicated node via k3s ServiceLB node selector.
  # externalTrafficPolicy: Local preserves source IP for Fail2ban.
  sipService = {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "${cfg.vmName}-sip";
      namespace = cfg.namespace;
      annotations."svccontroller.k3s.cattle.io/nodeselector" = "fusionpbx-dedicated=true";
    };
    spec = {
      type = "LoadBalancer";
      externalTrafficPolicy = "Local";
      selector."kubevirt.io/vm" = cfg.vmName;
      ports = [
        { name = "sip-tcp";     port = 5060; targetPort = 5060; protocol = "TCP"; }
        { name = "sip-udp";     port = 5060; targetPort = 5060; protocol = "UDP"; }
        { name = "sip-alt-tcp"; port = 5080; targetPort = 5080; protocol = "TCP"; }
        { name = "sip-alt-udp"; port = 5080; targetPort = 5080; protocol = "UDP"; }
      ];
    };
  };

  # ── LoadBalancer Service for RTP media ──────────────────────────
  # Generates one port entry per UDP port in the configured range.
  # Pinned to the dedicated node; externalTrafficPolicy: Local for
  # direct media path without SNAT.
  rtpService = {
    apiVersion = "v1";
    kind = "Service";
    metadata = {
      name = "${cfg.vmName}-rtp";
      namespace = cfg.namespace;
      annotations."svccontroller.k3s.cattle.io/nodeselector" = "fusionpbx-dedicated=true";
    };
    spec = {
      type = "LoadBalancer";
      externalTrafficPolicy = "Local";
      selector."kubevirt.io/vm" = cfg.vmName;
      ports = builtins.genList (i: let p = cfg.rtpPortRange.start + i; in {
        name = "rtp-${toString p}";
        port = p;
        targetPort = p;
        protocol = "UDP";
      }) rtpPortCount;
    };
  };

in
{
  options.openkrill.apps.fusion-pbx = {
    enable = mkEnableOption "FusionPBX VoIP PBX on KubeVirt";

    namespace = mkOption {
      type = types.str;
      default = "fusion-pbx";
      description = "Namespace for the FusionPBX deployment.";
    };

    vmName = mkOption {
      type = types.str;
      default = "fusion-pbx";
      description = "Name of the KubeVirt VirtualMachine resource.";
    };

    clusterNodes = mkOption {
      type = types.listOf types.str;
      description = ''
        Kubernetes node names to taint with
        `fusionpbx=dedicated:NoSchedule` and label with
        `fusionpbx-dedicated=true`.  The FusionPBX VM will be the only
        workload on these nodes, giving it exclusive access to the host
        network stack for SIP/RTP UDP traffic.
      '';
      example = [ "worker-voip-01" ];
    };

    image = mkOption {
      type = types.str;
      default = "quay.io/containerdisks/debian:12";
      description = ''
        Container disk image for the VM root filesystem.
        Must be a KubeVirt-compatible containerDisk image containing a
        virtual machine disk (qcow2/raw) at /disk/.  The standard
        containerdisks images from quay.io/containerdisks/ work here.
        The FusionPBX install script runs inside the VM via cloud-init
        on first boot.
      '';
    };

    dataSize = mkOption {
      type = types.str;
      default = "50Gi";
      description = "Size of the local-path PVC for FusionPBX data (recordings, database, logs).";
    };

    memory = mkOption {
      type = types.str;
      default = "24Gi";
      description = "Memory to request for the FusionPBX VM (e.g. '8Gi', '16Gi'). Default leaves ~6-8 GiB for the host OS, kubelet, and k3s.";
    };

    cpu = mkOption {
      type = types.int;
      default = 4;
      description = "Number of CPU cores for the FusionPBX VM.";
    };

    subdomain = mkOption {
      type = types.str;
      default = "pbx";
      description = "Subdomain for the FusionPBX web UI (e.g. pbx.<domain>).";
    };

    rtpPortRange = {
      start = mkOption {
        type = types.int;
        default = 16384;
        description = "First UDP port in the RTP media range.";
      };
      end = mkOption {
        type = types.int;
        default = 16484;
        description = ''
          Last UDP port (exclusive) in the RTP media range.
          Default range of 100 ports supports ~50 concurrent calls.
        '';
      };
    };

    sshAuthorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "SSH public keys to inject into the VM root user via cloud-init.";
    };

    extraManifests = helpers.mkExtraManifestsOption;
  };

  config = mkIf cfg.enable {
    # ── ArgoCD Application ──────────────────────────────────────────
    openkrill.apps.argo-cd.applications.fusion-pbx = mkIf config.openkrill.gitops.generateApplications {
      namespace = "argo-cd";
      project = "default";
      source = {
        repoURL = config.openkrill.gitops.repoURL;
        targetRevision = "rendered-manifests";
        path = ".";
        directory.include = "fusion-pbx.yaml";
      };
      destination = {
        server = "https://kubernetes.default.svc";
        namespace = cfg.namespace;
      };
      syncPolicy = {
        automated = { prune = true; selfHeal = true; };
        syncOptions = [ "CreateNamespace=true" ];
      };
    };

    # ── Web UI ingress (Traefik HTTPRoute via openkrill.ingress) ────
    openkrill.ingress.routes.fusion-pbx = {
      subdomain = cfg.subdomain;
      namespace = cfg.namespace;
      service   = "${cfg.vmName}-web";
      port      = 80;
      auth      = "forward";
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.fusion-pbx.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ taintResources
      ++ [ dataPVC vmResource webService sipService rtpService ];
  };
}
