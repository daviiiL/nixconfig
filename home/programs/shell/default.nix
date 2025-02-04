{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      la = "eza -la --icons --group-directories-first";
      tree = "tre";
      nixrebuild = "cd $HOME/nixconfig & sudo nixos-rebuild switch --flake .#$(hostname)";
      switchhome = "cd $HOME/nixconfig & home-manager switch --flake .#$USER@$(hostname)";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };
}
