{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      nur.repos.xddxdd.pterodactyl-wings
    ];
    virtualisation.docker.enable = true;
  };
}
