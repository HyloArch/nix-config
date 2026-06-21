{ config, lib, ... }:
let
  lang = symbol: color: {
    format = "[  [$symbol]($style) ($version)](none)";
    style = color;
    symbol = symbol;
    version_format = lib.replaceString ''\'' "" ''v\''${raw}'';
  };
  cfg = config.hylo.starship;
in
{
  options.hylo.starship = {
    palette = lib.mkOption {
      description = "The color palette to use for Starship";
      default = "default";
    };
  };
  config.programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      palette = cfg.palette;
      palettes = {
        default = {
          directory-fg = "#000000";
          directory-bg = "#758bd1";
          git-fg = "#000000";
          git-bg = "#ffbc4f";
          nix-shell-fg = "#000000";
          nix-shell-bg = "#42e3f5";
          time-fg = "#000000";
          time-bg = "#58bf54";
          success = "green";
          error = "red";
        };
        auburn = {
          directory-fg = "#000000";
          directory-bg = "#82889C";
          git-fg = "#000000";
          git-bg = "#e86100";
          nix-shell-fg = "#000000";
          nix-shell-bg = "#0093d2";
          time-fg = "#000000";
          time-bg = "#86b64e";
          success = "green";
          error = "red";
        };
        ares = {
          directory-fg = "#000000";
          directory-bg = "#f73636";
          git-fg = "#000000";
          git-bg = "#ff7575";
          nix-shell-fg = "#000000";
          nix-shell-bg = "#ffbfbf";
          time-fg = "#000000";
          time-bg = "#e67a7a";
          success = "#ffd6d6";
          error = "#ff0000";
        };
        tron = {
          directory-fg = "#000000";
          directory-bg = "#4ab7ff";
          git-fg = "#000000";
          git-bg = "#8fd2ff";
          nix-shell-fg = "#000000";
          nix-shell-bg = "#bae3ff";
          time-fg = "#000000";
          time-bg = "#89bde0";
          success = "#19a3ff";
          error = "#ff9f19";
        };
      };
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "[](fg:directory-bg)"
        "$directory"
        "[($git_branch$git_status)](fg:prev_bg bg:git-bg)"
        "[($nix_shell)](fg:prev_bg bg:nix-shell-bg)"
        "[](fg:prev_bg)"
        "($bun$c$cpp$golang$gradle$java$lua$maven$nodejs$python$rust$zig )"
        # "$fill"
        # "([[](fg:time)$cmd_duration](fg:time-fg bg:time-bg))"
        "$line_break"
        "$character"
      ];
      right_format = "([[](fg:time-bg)$cmd_duration](fg:time-fg bg:time-bg))";

      username = {
        format = " $user";
        show_always = true;
      };
      hostname = {
        format = "@$hostname ($ssh_symbol )";
        ssh_only = false;
        ssh_symbol = "󰣀";
      };
      directory = {
        format = "[ $path ]($style)";
        style = "fg:directory-fg bg:directory-bg";
        truncation_length = 5;
        truncate_to_repo = true;
        truncation_symbol = "…/";
        fish_style_pwd_dir_length = 1;
      };
      git_branch = {
        format = "[ $symbol $branch ]($style)";
        style = "fg:git-fg bg:git-bg";
        symbol = "";
      };
      git_status = {
        format = "[($modified )($staged )]($style)";
        style = "fg:git-fg bg:git-bg";
        modified = "󰦒";
        staged = "";
      };
      nix_shell = {
        format = "[ $state ]($style)";
        style = "fg:nix-shell-fg bg:nix-shell-bg";
        impure_msg = "󱄅";
      };
      bun = lang "" "#faf0df";
      c = lang "" "#abbbcf";
      cpp = lang "" "#659bd4";
      golang = lang "" "#6ad5e3";
      gradle = lang "" "#3db8c2";
      java = lang "" "#f29111";
      lua = lang "" "#00007f";
      maven = lang "" "#d7442e";
      nodejs = lang "" "#5ea04e";
      python = lang "" "#ffe05c";
      rust = lang "" "#e53a25";
      zig = lang "" "#f7a41d";
      character = {
        success_symbol = "[❯](bold success)";
        error_symbol = "[󰬅](bold error)";
      };
      cmd_duration = {
        format = "[ 󱎫 $duration ]($style)";
        style = "fg:time-fg bg:time-bg";
        min_time = 2000;
        show_milliseconds = true;
        show_notifications = false;
        min_time_to_notify = 30000;
      };
      fill = {
        symbol = " ";
        style = "";
      };
    };
  };
}
