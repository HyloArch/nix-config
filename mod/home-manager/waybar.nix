{ config, ... }:
{
  config.programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = {
      main = {
        layer = "bottom";
        position = "bottom";
        modules-left = [
          "tray"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "cpu"
          "clock"
        ];
        clock = {
          format = "{:%I:%M}";
        };
      };
    };
  };
}
