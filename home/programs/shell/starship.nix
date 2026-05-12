{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.programs.shell.starship;
  lang = icon: {
    symbol = icon;
    format = "[$symbol ](fg:mono_2)";
  };
  pad = {
    left = "";
    right = "";
  };
in {
  options.localHome.programs.shell.starship.enable =
    lib.mkEnableOption "starship prompt";

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        palette = "mono";
        palettes.mono = {
          mono_0 = "#ffffff";
          mono_1 = "#d0d0d0";
          mono_2 = "#a0a0a0";
          mono_3 = "#707070";
          mono_4 = "#3a3a3a";
        };

        format = lib.strings.concatStrings [
          "$time"
          "$nix_shell"
          "$container"
          "$python"
          "$nodejs"
          "$lua"
          "$rust"
          "$golang"
          "$java"
          "$scala"
          "$c"
          "$ruby"
          "$php"
          "$perl"
          "$haskell"
          "$elixir"
          "$erlang"
          "$swift"
          "$dart"
          "$elm"
          "$git_branch"
          "$git_status"
          "$cmd_duration"
          "$status"
          "$line_break"
          "$username"
          "[@](fg:mono_3)"
          "$hostname"
          "[:](fg:mono_3) "
          "$directory"
          " $character"
        ];

        continuation_prompt = "[∙  ┆ ](fg:mono_3)";
        line_break = {disabled = false;};

        username = {
          show_always = true;
          format = "[$user]($style)";
          style_user = "fg:mono_2";
          style_root = "fg:mono_0 bold";
        };

        hostname = {
          ssh_only = false;
          format = "[$hostname]($style)";
          style = "fg:mono_1";
        };

        directory = {
          format = "[${pad.left}](fg:mono_4)[$path](bg:mono_4 fg:mono_0)[${pad.right}](fg:mono_4)";
          truncation_length = 4;
          truncation_symbol = "…/";
          truncate_to_repo = false;
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
            "Videos" = " ";
            "Projects" = "󱌢 ";
            "Codespace" = "󱌢 ";
            "GitHub" = "";
            ".config" = " ";
            "Vault" = "󱉽 ";
          };
        };

        nix_shell = {
          disabled = false;
          symbol = "";
          format = "[${pad.left}](fg:mono_4)[ $symbol ](bg:mono_4 fg:mono_0)[${pad.right}](fg:mono_4) ";
        };

        container = {
          symbol = " 󰏖";
          format = "[$symbol ](fg:mono_3)";
        };

        git_branch = {
          symbol = "";
          format = "[ $symbol $branch](fg:mono_2)";
        };

        git_status = {
          format = "[ $all_status$ahead_behind](fg:mono_3)";
        };

        cmd_duration = {
          min_time = 1000;
          format = "[ $duration](fg:mono_3)";
        };

        status = {
          symbol = "✗";
          format = "[ $symbol](fg:mono_0 bold)";
          success_symbol = "";
          disabled = false;
        };

        character = {
          success_symbol = "[❯](fg:mono_1)";
          error_symbol = "[❯](fg:mono_0 bold)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          format = "[ $time](fg:mono_3) ";
        };

        python = lang "";
        nodejs = lang " ";
        lua = lang "󰢱";
        rust = lang "";
        golang = lang "";
        java = lang "";
        scala = lang "";
        c = lang "";
        ruby = lang "";
        php = lang "";
        perl = lang "";
        haskell = lang "";
        elixir = lang "";
        erlang = lang "";
        swift = lang "";
        dart = lang "";
        elm = lang "";
      };
    };
  };
}
