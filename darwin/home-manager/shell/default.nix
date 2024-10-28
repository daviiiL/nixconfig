let
  shellAliases = {
    ls = "eza --color --icons";
    ll = "eza --color --icons -l";
    la = "eza --color --icons -a";
    nixrebuild = "darwin-rebuild switch --flake ~/nixconfig";
    tree = "tre";
  };
in {
  imports = [./starship.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    inherit shellAliases;
    dirHashes = {
      doc = "$HOME/Documents";
      git = "$HOME/Documents/git";
      proj = "$HOME/Documents/git/projs";
      dsa = "$HOME/Documents/git/dsa";
      nixconfig = "$HOME/nixconfig";
    };
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      . "$HOME/.asdf/asdf.sh"
    '';
  };
}
