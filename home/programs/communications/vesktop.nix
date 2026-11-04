{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.communications.vesktop;
in {
  options.localHome.programs.communications.vesktop.enable =
    lib.mkEnableOption "Vesktop (Discord client)";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.vesktop];
  };
}
