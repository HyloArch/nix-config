{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # pixieditor # Doesn't work >:(
    obsidian
  ];
}
