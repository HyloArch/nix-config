{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-tree
    nixd
  ];

  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "HyloArch";
          email = "92276260+HyloArch@users.noreply.github.com";
        };
        safe.directory = "/etc/nixos";
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {

      } // (if pkgs.stdenv.hostPlatform.isDarwin then {
        snrds = "sudo nix run nix-darwin -- switch --flake ~/dotfiles";
      } else {
        snrbs = "sudo nixos-rebuild switch";
      });
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
    };
    btop.enable = true;
    home-manager.enable = true;
  };
}
