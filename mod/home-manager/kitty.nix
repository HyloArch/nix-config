{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "GeistMono Nerd Font Mono";
      size = 16;
    };
    themeFile = "OneDark-Pro";
    shellIntegration.enableZshIntegration = true;
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
    };
  };
}
