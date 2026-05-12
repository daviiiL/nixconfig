{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.browsers.chromium;
in {
  options.localHome.programs.browsers.chromium.enable =
    lib.mkEnableOption "ungoogled-chromium browser";

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
