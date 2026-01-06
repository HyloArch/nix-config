{ ... }:
{
  imports = [ ./greetd.nix ];
  config = {
    # services.xserver.displayManager.sddm = {
    #   enable = true;
    #   wayland.enable = true;
    # };

    programs.hyprland.enable = true;
    security.pam.services.swaylock = {};
    home-manager.sharedModules = [ ./home-manager/hyprland.nix ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
