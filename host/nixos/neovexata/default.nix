{ getModule, ... }:
{
  system = "x86_64-linux";
  modules = [
    (getModule /hyprland.nix)
    (getModule /ui.nix)
    (getModule /nvidia.nix)
  ];
  users.hyloarch = {
    homeDirectory = "/home/hyloarch";
    homeModules = [
      (getModule /home-manager/ui-apps.nix)
      (getModule /home-manager/vscode.nix)
    ];
  };
}
