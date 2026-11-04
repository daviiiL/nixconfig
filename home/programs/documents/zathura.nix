{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.documents.zathura;
in {
  options.localHome.programs.documents.zathura.enable =
    lib.mkEnableOption "zathura document viewer";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.zathura];
  };
}
