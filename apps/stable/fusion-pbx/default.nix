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
{ config, lib, pkgs, k8s, ... }:
with lib;
let
  cfg = config.openkrill.apps.fusion-pbx;
  helpers = import ../../../modules/lib/helpers.nix { inherit lib; };
  route = config.openkrill.ingress.routes.fusion-pbx;
  fqdn = "${route.subdomain}.${route.domain}";

  rtpPortCount = cfg.rtpPortRange.end - cfg.rtpPortRange.start;

  # ── Cloud-init user data ──────────────────────────────────────
  # Stored in a Secret (userDataSecretRef) because KubeVirt's inline
  # userData has a 2048-byte limit.
  cloudInitUserData = concatStringsSep "\n" ([
    "#cloud-config"
    "package_update: true"
    "package_upgrade: true"
    "packages:"
    "  - wget"
    "  - ca-certificates"
    "  - qemu-guest-agent"
    "runcmd:"
    "  - 'systemctl enable --now qemu-guest-agent'"
    # ── FusionPBX install ─────────────────────────────────
    "  - 'wget -O - https://raw.githubusercontent.com/fusionpbx/fusionpbx-install.sh/master/debian/pre-install.sh | sh'"
    "  - 'cd /usr/src/fusionpbx-install.sh/debian && ./install.sh'"
    # Narrow FreeSWITCH RTP port range
    "  - \"sed -i 's/16384/${toString cfg.rtpPortRange.start}/' /etc/freeswitch/autoload_configs/switch.conf.xml\""
    "  - \"sed -i 's/32768/${toString (cfg.rtpPortRange.end - 1)}/' /etc/freeswitch/autoload_configs/switch.conf.xml\""
    "  - 'systemctl restart freeswitch || true'"
    # ── Deploy TLS cert + CA bundle from mounted volumes ──
    "  - |"
    "    mkdir -p /mnt/tls"
    "    mount /dev/$(lsblk -o NAME,SERIAL -rn | awk '/TLSCERT/{print $1}') /mnt/tls"
    "    cp /mnt/tls/tls.crt /etc/ssl/certs/nginx.crt"
    "    cp /mnt/tls/tls.key /etc/ssl/private/nginx.key"
    "    mkdir -p /etc/freeswitch/tls"
    "    cat /mnt/tls/tls.crt /mnt/tls/tls.key > /etc/freeswitch/tls/wss.pem"
    "    cat /mnt/tls/tls.crt /mnt/tls/tls.key > /etc/freeswitch/tls/tls.pem"
    "    chown -R www-data:www-data /etc/freeswitch/tls/ 2>/dev/null || true"
    "    umount /mnt/tls"
    "    mkdir -p /mnt/ca"
    "    mount /dev/$(lsblk -o NAME,SERIAL -rn | awk '/CABUNDLE/{print $1}') /mnt/ca"
    "    cp /mnt/ca/bundle.pem /usr/local/share/ca-certificates/openkrill-ca.crt"
    "    update-ca-certificates"
    "    umount /mnt/ca"
    "    systemctl reload nginx || true"
    "    systemctl restart freeswitch || true"
    "    cat > /etc/cron.daily/refresh-tls <<'CRONEOF'"
    "    #!/bin/sh"
    "    DEV=$(lsblk -o NAME,SERIAL -rn | awk '/TLSCERT/{print $1}')"
    "    [ -z \"$DEV\" ] && exit 0"
    "    mkdir -p /mnt/tls && mount /dev/$DEV /mnt/tls 2>/dev/null || exit 0"
    "    cp /mnt/tls/tls.crt /etc/ssl/certs/nginx.crt"
    "    cp /mnt/tls/tls.key /etc/ssl/private/nginx.key"
    "    cat /mnt/tls/tls.crt /mnt/tls/tls.key > /etc/freeswitch/tls/wss.pem"
    "    cat /mnt/tls/tls.crt /mnt/tls/tls.key > /etc/freeswitch/tls/tls.pem"
    "    umount /mnt/tls"
    "    systemctl reload nginx"
    "    CRONEOF"
    "    chmod +x /etc/cron.daily/refresh-tls"
    # ── Set admin password from pre-hashed secret ───────
    "  - |"
    "    mkdir -p /mnt/admin"
    "    DEV=$(lsblk -o NAME,SERIAL -rn | awk '/ADMINPASS/{print $1}')"
    "    if [ -n \"$DEV\" ]; then"
    "      mount /dev/$DEV /mnt/admin 2>/dev/null || true"
    "      if [ -f /mnt/admin/ADMIN_PASSWORD ]; then"
    "        HASH=$(cat /mnt/admin/ADMIN_PASSWORD)"
    "        sudo -u postgres psql -d fusionpbx -c \"UPDATE v_users SET password='$HASH' WHERE username='admin';\" || true"
    "      fi"
    "      umount /mnt/admin"
    "    fi"
    # ── Set FusionPBX domain to match the ingress route ──
    "  - \"sudo -u postgres psql -d fusionpbx -c \\\"UPDATE v_domains SET domain_name='${fqdn}' WHERE domain_name LIKE '10.%' OR domain_name LIKE '172.%';\\\"\""
    # ── NGINX reverse proxy config ────────────────────────
    "  - 'sed -i \"/server_name/a\\\\\\tset_real_ip_from 10.42.0.0/16;\\n\\treal_ip_header X-Forwarded-For;\" /etc/nginx/sites-available/fusionpbx || true'"
    "  - 'nginx -t && systemctl reload nginx || true'"
    # ── Open PostgreSQL for PostgREST (pod network access) ──
    "  - |"
    "    PG_CONF=$(find /etc/postgresql -name postgresql.conf 2>/dev/null | head -1)"
    "    if [ -n \"$PG_CONF\" ]; then"
    "      sed -i \"s/#listen_addresses = .*/listen_addresses = '*'/\" \"$PG_CONF\""
    "      PG_HBA=$(find /etc/postgresql -name pg_hba.conf 2>/dev/null | head -1)"
    "      grep -q '10.42.0.0' \"$PG_HBA\" || echo 'host fusionpbx authenticator 10.42.0.0/16 md5' >> \"$PG_HBA\""
    "      systemctl restart postgresql || true"
    "    fi"
    "  - 'iptables -C INPUT -p tcp -s 10.42.0.0/16 --dport 5432 -j ACCEPT 2>/dev/null || iptables -I INPUT 21 -p tcp -s 10.42.0.0/16 --dport 5432 -j ACCEPT'"
    "  - 'iptables-save > /etc/iptables/rules.v4 2>/dev/null || true'"
  ] ++ optionals (cfg.sshAuthorizedKeys != []) [
    "users:"
    "  - name: root"
    "    ssh_authorized_keys:"
  ] ++ map (k: "      - ${builtins.toJSON k}") cfg.sshAuthorizedKeys);

  # Secret holding the cloud-init userdata
  cloudInitSecret = {
    apiVersion = "v1";
    kind = "Secret";
    metadata = { name = "${cfg.vmName}-cloudinit"; namespace = cfg.namespace; };
    type = "Opaque";
    stringData.userdata = cloudInitUserData;
  };

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
    metadata = {
      name = cfg.vmName;
      namespace = cfg.namespace;
      annotations."argocd.argoproj.io/sync-options" = "Replace=true";
    };
    spec = {
      runStrategy = "Always";

      # CDI imports the Debian 12 container disk image into a real
      # PVC.  The VM boots from a full-size persistent disk.
      dataVolumeTemplates = [{
        metadata = {
          name = "${cfg.vmName}-rootdisk";
          annotations."cdi.kubevirt.io/storage.pod.tolerations" = builtins.toJSON [{
            key = "fusionpbx";
            operator = "Equal";
            value = "dedicated";
            effect = "NoSchedule";
          }];
        };
        spec = {
          storage = {
            accessModes = [ "ReadWriteOnce" ];
            resources.requests.storage = cfg.dataSize;
            storageClassName = "local-path";
          };
          source.registry.url = "docker://${cfg.image}";
        };
      }];

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
                { name = "tls-cert"; disk.bus = "virtio"; disk.readonly = true; serial = "TLSCERT"; }
                { name = "ca-bundle"; disk.bus = "virtio"; disk.readonly = true; serial = "CABUNDLE"; }
                { name = "admin-pass"; disk.bus = "virtio"; disk.readonly = true; serial = "ADMINPASS"; }
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
              dataVolume.name = "${cfg.vmName}-rootdisk";
            }
            {
              name = "tls-cert";
              secret.secretName = cfg.tlsSecretName;
            }
            {
              name = "ca-bundle";
              configMap.name = "openkrill-ca-bundle";
            }
            {
              name = "admin-pass";
              secret.secretName = "${cfg.vmName}-admin";
            }
            {
              name = "cloudinit";
              cloudInitNoCloud.secretRef.name = "${cfg.vmName}-cloudinit";
            }
          ];
        };
      };
    };
  };

  # ── cert-manager Certificate for backend TLS ─────────────────────
  # Signed by openkrill-signing-authority; Traefik trusts it via the
  # trust-manager CA bundle.  Mounted into the VM as a KubeVirt
  # secret disk and deployed to NGINX/FreeSWITCH by cloud-init.
  tlsCertificate = {
    apiVersion = "cert-manager.io/v1";
    kind = "Certificate";
    metadata = { name = cfg.tlsSecretName; namespace = cfg.namespace; };
    spec = {
      secretName = cfg.tlsSecretName;
      dnsNames = [
        cfg.vmName
        "${cfg.vmName}-web"
        "${cfg.vmName}-web.${cfg.namespace}.svc"
        "${cfg.vmName}-web.${cfg.namespace}.svc.cluster.local"
      ];
      issuerRef = {
        name = "openkrill-signing-authority";
        kind = "ClusterIssuer";
      };
    };
  };

  # ── ClusterIP Service for Web UI (fronted by Traefik HTTPRoute) ─
  # The VM's NGINX serves HTTPS on 443 with a cert signed by
  # openkrill-signing-authority.  Traefik connects to the backend
  # over HTTPS; the BackendTLSPolicy handles SNI and verification.
  webService = {
    apiVersion = "v1";
    kind = "Service";
    metadata = { name = "${cfg.vmName}-web"; namespace = cfg.namespace; };
    spec = {
      selector."kubevirt.io/vm" = cfg.vmName;
      ports = [{
        name = "https";
        port = 443;
        targetPort = 443;
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
      default = "200Gi";
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

    tlsSecretName = mkOption {
      type = types.str;
      default = "${cfg.vmName}-tls";
      description = ''
        Name of the cert-manager Certificate / K8s Secret (tls.crt + tls.key)
        deployed into the VM for NGINX and FreeSWITCH TLS.  A cert-manager
        Certificate resource is created automatically, signed by the
        openkrill-signing-authority ClusterIssuer.
      '';
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
    # ── CDI workload tolerations ─────────────────────────────────────
    # The dedicated node(s) are tainted with fusionpbx=dedicated:NoSchedule.
    # CDI importer pods must tolerate this taint to import the VM disk
    # image onto the local-path PV on the tainted node.
    # The cdi-cr Helm chart is a static manifest (no templating), so we
    # deploy the CDI CR with tolerations from the fusion-pbx manifests.

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
      port      = 443;
      auth      = "forward";
      issuerRef.name = "letsencrypt";
    };

    # ── Backend TLS policy ──────────────────────────────────────────
    # The VM's NGINX serves HTTPS with a cert signed by
    # openkrill-signing-authority.  The BackendTLSPolicy tells Traefik
    # to use the service FQDN as the SNI hostname and to trust the
    # system CA bundle (trust-manager mounts the openkrill CA into
    # Traefik's /etc/ssl/certs).
    openkrill.apps."gateway-api".backendtlspolicies.fusion-pbx-web = {
      namespace = cfg.namespace;
      targetRefs = [{
        group = "";
        kind = "Service";
        name = "${cfg.vmName}-web";
      }];
      validation = {
        hostname = "${cfg.vmName}-web.${cfg.namespace}.svc";
        wellKnownCACertificates = "System";
      };
    };

    # ── Secret generator (reads LLDAP admin password) ──────────────
    # Runs on the host at boot.  Reads the LLDAP admin password,
    # bcrypt-hashes it, and stores the hash in openkrill-fusion-pbx
    # in the secret-store namespace.  Same pattern as filestash.
    openkrill.secrets.generators.fusion-pbx = {
      packages = with pkgs; [ openssl apacheHttpd ];
      after = [ "lldap" ];
      script = ''
        LLDAP_PASS=""
        if kubectl -n "$NS" get secret openkrill-lldap >/dev/null 2>&1; then
          LLDAP_PASS=$(kubectl -n "$NS" get secret openkrill-lldap \
            -o jsonpath='{.data.LLDAP_LDAP_USER_PASS}' | base64 -d)
        fi

        ADMIN_HASH=""
        if [ -n "$LLDAP_PASS" ]; then
          ADMIN_HASH=$(htpasswd -nbBC 10 "" "$LLDAP_PASS" | cut -d: -f2)
        else
          ADMIN_HASH=$(htpasswd -nbBC 10 "" "$(openssl rand -hex 16)" | cut -d: -f2)
        fi

        create_secret openkrill-fusion-pbx \
          --from-literal=ADMIN_PASSWORD="$ADMIN_HASH"
      '';
    };

    # ── ExternalSecret: sync admin password hash ───────────────────
    # Syncs the bcrypt-hashed admin password from openkrill-fusion-pbx
    # in secret-store → fusion-pbx namespace.  The hash is generated
    # by the fusion-pbx secret generator from the LLDAP admin password.
    openkrill.apps.external-secrets.secrets."${cfg.vmName}-admin" = {
      namespace = cfg.namespace;
      remoteSecretName = "openkrill-fusion-pbx";
      keys = [ "ADMIN_PASSWORD" ];
    };

    # ── Manifests ───────────────────────────────────────────────────
    openkrill.manifests.fusion-pbx.content =
      [ (k8s.mkNamespace cfg.namespace) ]
      ++ taintResources
      ++ [
        # CDI CR with workload tolerations for the tainted node
        {
          apiVersion = "cdi.kubevirt.io/v1beta1";
          kind = "CDI";
          metadata.name = "cdi";
          spec = {
            config.featureGates = [ "HonorWaitForFirstConsumer" "WebhookPvcRendering" ];
            imagePullPolicy = "IfNotPresent";
            infra.nodeSelector."kubernetes.io/os" = "linux";
            workload = {
              nodeSelector."kubernetes.io/os" = "linux";
              tolerations = [{
                key = "fusionpbx";
                operator = "Equal";
                value = "dedicated";
                effect = "NoSchedule";
              }];
            };
          };
        }
        # StorageProfile for local-path — CDI does not recognise the
        # rancher.io/local-path provisioner, so the auto-created profile
        # has an empty spec.  Without claimPropertySets CDI cannot
        # determine accessMode / volumeMode for scratch PVCs.
        {
          apiVersion = "cdi.kubevirt.io/v1beta1";
          kind = "StorageProfile";
          metadata.name = "local-path";
          spec.claimPropertySets = [{
            accessModes = [ "ReadWriteOnce" ];
            volumeMode = "Filesystem";
          }];
        }
        tlsCertificate cloudInitSecret vmResource webService sipService rtpService
      ];
  };
}
