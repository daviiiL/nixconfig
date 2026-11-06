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

    # adw-gtk3 already comes from theme.base
    home.packages = [pkgs.matugen];
  };
}
