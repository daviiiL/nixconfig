{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true;
    };
    dirHashes = {
      git = "$HOME/Git";
      nixconfig = "$HOME/nixconfig";
    };
  };
}
