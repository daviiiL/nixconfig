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
  home.packages = with unstable-pkgs; [
    gnupg
    direnv
  ];

  imports = [
    ./alacritty.nix
    ./android-dev.nix
    ./vscode.nix
  ];
}
