{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dirHashes = {
      doc = "$HOME/Documents";
      git = "$HOME/Documents/git";
      proj = "$HOME/Documents/git/curProj";
      nixconfig = "~/nixconfig";
    };
    shellAliases = {
      la = "eza -la";
      ls = "eza";
      rebuildsystem = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndr";
      switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndr";
      code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };

  };
}
