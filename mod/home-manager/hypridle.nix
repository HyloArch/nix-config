{ lib, ... }:
{
  config = {
    services.hypridle = {
      enable = true;
    };

    programs = {
      hyprlock = {
        enable = true;
      };
    };
  };
}
