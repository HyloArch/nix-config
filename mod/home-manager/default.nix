{ pkgs, lib, ... }:
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
        nix-shell = "nix-shell --run zsh";
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
    starship = {
      enable = false;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "[░▒▓](#a3aed2)"
          "[  $nix_shell ](bg:#a3aed2 fg:#090c0c)"
          "[](bg:#769ff0 fg:#a3aed2)"
          "$directory"
          "[](fg:#769ff0 bg:#394260)"
          "$git_branch"
          "$git_status"
          "[](fg:#394260 bg:#212736)"
          "$nodejs"
          "$rust"
          "$golang"
          "$php"
          "[](fg:#212736 bg:#1d2230)"
          "$time"
          "[ ](fg:#1d2230)"
          "\n$character"
        ];
        nix_shell = {
          impure_msg = "nix";
          format = "$state";
        };
        directory = {
          style = "fg:#e3e5e5 bg:#769ff0";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
        git_branch = {
          symbol = "";
          style = "bg:#394260";
          format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
        };
        git_status = {
          style = "bg:#394260";
          format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        };
        nodejs = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        rust = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        golang = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        php = {
          symbol = "";
          style = "bg:#212736";
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        };
        time = {
          disabled = false;
          time_format = "%R"; # Hour:Minute Format
          style = "bg:#1d2230";
          format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
        };
      };
    };
    btop.enable = true;
    home-manager.enable = true;
  };
}
