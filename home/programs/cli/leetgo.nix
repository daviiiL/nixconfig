{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.cli.leetgo;
in {
  options.localHome.programs.cli.leetgo.enable =
    lib.mkEnableOption "leetgo (leetcode CLI)";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.leetgo];
  };
}
