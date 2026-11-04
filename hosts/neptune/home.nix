{
  localHome = {
    platform.darwin.applications.enable = true;
    programs = {
      shell = {
        zsh.enable = true;
        starship.enable = true;
      };
      cli = {
        coreutils.enable = true;
        opencode.enable = true;
        networking.enable = true;
        ripgrep.enable = true;
      };
      development = {
        direnv.enable = true;
        devenv.enable = true;
        git.enable = true;
        aws.enable = true;
        languages = {
          node.enable = true;
          dart.enable = true;
          php.enable = true;
          latex.enable = true;
          nix.enable = true;
        };
        databases = {
          mysql.enable = true;
          postgresql.enable = true;
        };
      };
      editors.tree-sitter.enable = true;
      terminals = {
        tmux.enable = true;
        zellij.enable = true;
      };
    };
  };
}
