{
  localHome = {
    programs = {
      shell = {
        zsh.enable = true;
        starship.enable = true;
      };
      cli = {
        coreutils.enable = true;
        claude-code.enable = true;
        fastfetch.enable = true;
      };
      development = {
        devenv.enable = true;
        languages.php.enable = true;
      };
      editors = {
        nixvim.enable = true;
      };
      documents.zathura.enable = true;
    };
  };
}
