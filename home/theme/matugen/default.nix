{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.theme.matugen;
in {
  options.localHome.theme.matugen.enable =
    lib.mkEnableOption "matugen dynamic colorscheme generation (adw-gtk3)";

  config = lib.mkIf cfg.enable {
    localHome.theme.base.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      adw-gtk3
      matugen
    ];
  };
}
