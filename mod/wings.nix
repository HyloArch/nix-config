{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      docker
      nur.repos.xddxdd.pterodactyl-wings
    ];
  };
}
