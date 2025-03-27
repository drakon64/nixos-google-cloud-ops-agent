{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.google-cloud-ops-agent;

  opsAgent = pkgs.callPackage ./google-cloud-ops-agent { };
in
{
  options.services.google-cloud-ops-agent.enable = lib.mkEnableOption "Enable the Google Cloud Ops Agent";

  config = lib.mkIf cfg.enable {
    systemd.services = {
      google-cloud-ops-agent = {
        serviceConfig = {
          Type = "oneshot";
          ExecStartPre = "${opsAgent}/bin/google_cloud_ops_agent_engine";
          ExecStart = "${pkgs.coreutils}/bin/true";
          RemainAfterExit = true;
        };

        unitConfig = {
          Description = "Google Cloud Ops Agent";
          Wants = "google-cloud-ops-agent-diagnostics.service network-online.target";
          After = "network-online.target";
        };

        #installConfig.WantedBy = "multi-user.target";
      };

      google-cloud-ops-agent-diagnostics = {
        serviceConfig = {
          Type = "simple";
          ExecStart = "${opsAgent}/bin/google_cloud_ops_agent_diagnostics";
          Restart = "always";
        };

        unitConfig = {
          Description = "Google Cloud Ops Agent - Diagnostics";
          PartOf = "google-cloud-ops-agent.service";
          Requires = "network-online.target";
          After = "network-online.target";
        };

        #installConfig.WantedBy = "multi-user.target";
      };
    };
  };
}
