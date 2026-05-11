{
  config,
  lib,
  pkgs,
  ...
}: {
  options.localSystem.core.shell = {
    enable = lib.mkEnableOption "zsh as the default user shell";
  };

  config = lib.mkIf config.localSystem.core.shell.enable {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
