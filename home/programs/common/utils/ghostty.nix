{
  inputs,
  pkgs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    package =
      if pkgs.stdenv.isDarwin
      then unstable.ghostty-bin
      else pkgs.ghostty;
  };
}
