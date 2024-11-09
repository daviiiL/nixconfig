{
  pkgs,
  inputs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  home.packages = with pkgs; [
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
    bicep
    nil
    nixd

    # editors
    inputs.nixvim.packages.${pkgs.system}.default
    unstable-pkgs.zed-editor
    helix
  ];
}
