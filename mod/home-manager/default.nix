{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-tree
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        snrds = "sudo nix run nix-darwin -- switch --flake ~/dotfiles";
      };
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
    };
    kitty = {
      enable = true;
      font = {
        name = "GeistMono Nerd Font Mono";
        size = 16;
      };
      themeFile = "OneDark-Pro";
    };
    btop.enable = true;
    home-manager.enable = true;
  };
}
