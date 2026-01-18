{ getModule, ... }:
{
  system = "x86_64-linux";
  modules = [
    (getModule /ssh.nix)
    (getModule /wings.nix)
  ];
  users.hyloarch = {
    homeDirectory = "/home/hyloarch";
    homeModules = [

    ];
  };
}
