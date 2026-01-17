{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
  ];

  config = {
    home.packages = with pkgs; [
      kdePackages.dolphin
      zed-editor
      firefox
      prismlauncher

    ];

    xdg = {
      desktopEntries = {
        shutdown = {
          name = "Shutdown";
          exec = "shutdown now";
          categories = [ "Utility" ];
        };
        reboot = {
          name = "Reboot";
          exec = "reboot";
          categories = [ "Utility" ];
        };
      };
    };
  };
}
