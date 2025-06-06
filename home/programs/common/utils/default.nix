{
  inputs,
  pkgs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  imports = [
    ./starship.nix
    ./nixvim.nix
    ./ghostty.nix
  ];

  home.packages = with unstable-pkgs; [
    #dev
    gh
    devenv
    vscode-fhs
    claude-code

    #boring but abs necessity
    libreoffice
    zathura
    obsidian

    #system tools
    tre-command
    eza
    powertop
    btop
    xdg-utils
    zip
    unzip
    neofetch
  ];
}
