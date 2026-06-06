{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pixieditor
    obsidian
  ];
}
