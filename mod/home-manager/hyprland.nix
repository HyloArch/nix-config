{ config, pkgs, lib, ... }:
{
  imports = [
    ./hypridle.nix
    ./waybar.nix
  ];
  options.host.hyprland.monitor = lib.mkOption {
    default = [ ", highres, auto, auto" ];
    description = "List of monitor configurations.";
  };
  config = {
    programs.tofi = {
      enable = true;
      settings = {
        drun-launch = true;
      };
    };

    home.activation = {
      hypreload =
        lib.hm.dag.entryAfter
          [
            "writeBoundary"
          ]
          ''
            (
              XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}
              if [[ -d "/tmp/hypr" || -d "$XDG_RUNTIME_DIR/hypr" ]]; then
                for i in $(${pkgs.hyprland}/bin/hyprctl instances -j | jq ".[].instance" -r); do
                ${pkgs.hyprland}/bin/hyprctl -i "$i" reload
                done
              fi
            )
          '';
        regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          tofi_cache=${config.xdg.cacheHome}/tofi-drun
          [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
        '';
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        exec-once = "hyprlock";
        monitor = config.host.hyprland.monitor;
        workspace = builtins.concatLists (
          let
            count = builtins.length config.host.hyprland.monitor;
            monitors = builtins.map (x: builtins.elemAt (builtins.split "," x) 0) config.host.hyprland.monitor;
          in
          builtins.genList (
            x: builtins.genList (
              y: "${toString ((count * x) + y + 1)}, monitor:${builtins.elemAt monitors y}"
            ) count
          ) 8
        );
        "$mod" = "SUPER";
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bind = [
          "$mod, r, exec, tofi-drun"
          "$mod, p, exec, hyprlock"
          "$mod, k, exec, kitty"

          "$mod, q, killactive,"
          "$mod, n, togglefloating,"
          "$mod, f, fullscreen, 0"

          "$mod SHIFT, left, workspace, -1"
          "$mod SHIFT, right, workspace, +1"
        ];
      };
    };
  };
}
