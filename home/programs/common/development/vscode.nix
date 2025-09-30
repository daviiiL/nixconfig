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
  programs.vscode = {
    enable = true;
    package = unstable-pkgs.vscode;

    profiles.default = {
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
    };
  };
}
