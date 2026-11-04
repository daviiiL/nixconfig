{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.core.shell;
in {
  options.localSystem.core.shell = {
    enable = lib.mkEnableOption "zsh as the default user shell";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
