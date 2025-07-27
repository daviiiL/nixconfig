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
    ../programs/common/utils/ghostty.nix
    ../programs/common/utils/nixvim.nix
    ../programs/common/utils/starship.nix
    ../programs/common/utils/fastfetch.nix
    ../programs/common/shell
    ../programs/common/browser/firefox.nix
    ../programs/common/communications
    ./utils
  ];

  home.packages = with pkgs; [
    # dev tools
    devenv
    gh

    # system tools
    eza
  ];
}
