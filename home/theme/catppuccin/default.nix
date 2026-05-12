{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.localHome.theme.catppuccin;
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./ghostty.nix
  ];

  options.localHome.theme.catppuccin.enable =
    lib.mkEnableOption "Catppuccin theming (mocha, mauve accent)";

  config = lib.mkIf cfg.enable {
    localHome.theme.base.enable = lib.mkDefault true;

    catppuccin = {
      accent = "mauve";
      flavor = "mocha";
    };
  };
}
