{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.development.gnupg;
in {
  options.localHome.programs.development.gnupg.enable =
    lib.mkEnableOption "GnuPG";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.gnupg];
  };
}
