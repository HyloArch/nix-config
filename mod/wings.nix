{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      nur.repos.xddxdd.pterodactyl-wings
    ];
    virtualisation.docker.enable = true;

    systemd.services.wings = {
      description = "Pterodactyl Wings Daemon";
      after = [ "docker.service" ];
      requires = [ "docker.service" ];
      partOf = [ "docker.service" ];
      serviceConfig = {
        User = "root";
        WorkingDirectory = "/etc/pterodactyl";
        LimitNOFILE = 4096;
        PIDFile = "/var/run/wings/daemon.pid";
        ExecStart = "${pkgs.nur.repos.xddxdd.pterodactyl-wings}/bin/wings";
        Restart = "on-failure";
        StartLimitInterval = 180;
        StartLimitBurst = 30;
        RestartSec = 5;
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
