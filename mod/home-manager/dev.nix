{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustc
    cargo
    bun
    podman
    maven
  ];
}
