{
  localHome = {
    programs = {
      shell.zsh.enable = true;
      shell.starship.enable = true;
      editors.nixvim.enable = true;
      terminals.alacritty.enable = true;
      browsers.firefox.enable = true;
      development.core.enable = true;
      communications.enable = true;
      cli.coreutils.enable = true;
      cli.fastfetch.enable = true;
    };
    platform.darwin.applications.enable = true;
  };
}
