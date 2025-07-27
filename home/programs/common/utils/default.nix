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
    ./fastfetch.nix
  ];

  home.packages = with unstable-pkgs; [
    #dev
    gh
    devenv
    claude-code
    php

    #boring but abs necessity
    zathura

    #system tools
    eza
    btop
    xdg-utils
    zip
    unzip
    neofetch
  ];
}
