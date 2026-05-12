{
  config,
  lib,
  unstablePkgs,
  ...
}: let
  cfg = config.localHome.programs.cli.leetgo;
in {
  options.localHome.programs.cli.leetgo.enable =
    lib.mkEnableOption "leetgo (leetcode CLI)";

  config = lib.mkIf cfg.enable {
    home.packages = [unstablePkgs.leetgo];
  };
}
