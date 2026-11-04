{
  localHome = {
    wm = {
      gnome.enable = true;
      niri.enable = true;
    };
    theme = {
      base.enable = true;
      gnome-custom.enable = true;
    };
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
        gnupg.enable = true;
        direnv.enable = true;
        devenv.enable = true;
        languages.php.enable = true;
      };
      editors = {
        nixvim.enable = true;
        vscode.enable = true;
      };
      documents.zathura.enable = true;
      terminals = {
        alacritty.enable = true;
        ghostty.enable = true;
      };
      browsers = {
        firefox.enable = true;
        chromium.enable = true;
      };
      communications.vesktop.enable = true;
    };
  };
}
