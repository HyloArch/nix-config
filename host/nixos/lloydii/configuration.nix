{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      8493
      8080
    ];
  #  allowedUDPPortRanges = [
  #    {
  #      from = 28000; 
  #      to = 28010;
  #    }
  #  ];
  #  allowedTCPPortRanges = [
  #    {
  #      from = 28000;
  #      to = 28010;
  #    }
  #  ];
  };
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
