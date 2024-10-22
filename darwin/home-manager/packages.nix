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
  home.packages = with pkgs; [
    # essentials
    git
    zip
    xz
    unzip
    p7zip
    gh

    # lsps & formatters
    typescript
    alejandra
    prettierd
    black
    isort
    jq
    stylua
    shellcheck
    shfmt
    shellharden
    nil
    nixd

    # editors
    inputs.nixvim.packages.${pkgs.system}.default
    helix

    # dev tools
    dart-sass
    ripgrep
  ];
}
