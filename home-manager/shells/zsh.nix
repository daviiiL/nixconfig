{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dirHashes = {
      doc = "$HOME/Documents";
      git = "$HOME/Documents/git";
      proj = "$HOME/Documents/git/projs";
      nixconfig = "$HOME/nixconfig";
    };
  };
}
