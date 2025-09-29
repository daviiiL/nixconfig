{
  pkgs,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  imports = [
    ../programs/common/utils/nixvim.nix
    ../programs/common/utils/starship.nix
    ../programs/common/utils/fastfetch.nix
    ../programs/common/shell
    ../programs/common/browsers/firefox.nix
    ../programs/common/communications
    ../programs/common/development
    ./utils
  ];

  home.packages = with unstable; [
    # dev tools
    devenv
    gh
    claude-code

    # system tools
    eza
    btop
    fzf
  ];
}
