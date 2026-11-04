{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.cli.opencode;
in {
  options.localHome.programs.cli.opencode.enable =
    lib.mkEnableOption "opencode AI coding agent";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.opencode];
  };
}
