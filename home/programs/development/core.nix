{
  config,
  lib,
  unstablePkgs,
  ...
}: let
  cfg = config.localHome.programs.development.core;
in {
  options.localHome.programs.development.core.enable =
    lib.mkEnableOption "core development tools (gnupg, direnv)";

  config = lib.mkIf cfg.enable {
    home.packages = with unstablePkgs; [
      gnupg
      direnv
    ];
  };
}
