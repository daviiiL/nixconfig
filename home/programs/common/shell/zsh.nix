{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;

    dirHashes = {
      docs = "$HOME/Documents/";
      codespace = "$HOME/Codespace/";
      nixconfig = "$HOME/nixconfig/";
    };

    shellAliases = {
      ls = "eza --icons --group-directories-first";
      la = "eza -la --icons --group-directories-first";
      tree = "eza --tree --icons";
      nixrebuild =
        if pkgs.stdenv.isDarwin
        then "sudo darwin-rebuild switch --flake $HOME/nixconfig#$(hostname)"
        else "sudo nixos-rebuild switch --flake $HOME/nixconfig#$(hostname)";
      switchhome = "home-manager switch --flake $HOME/nixconfig#$USER@$(hostname)";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };
}
