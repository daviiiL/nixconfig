{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dirHashes = {
      git = "$HOME/Git";
      nixconfig = "$HOME/nixconfig";
    };
  };
}
