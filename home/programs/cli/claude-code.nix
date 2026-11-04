{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.cli.claude-code;
in {
  options.localHome.programs.cli.claude-code.enable =
    lib.mkEnableOption "Claude Code CLI";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.claude-code];
  };
}
