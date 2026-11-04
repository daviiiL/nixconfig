{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.services.printing;
in {
  options.localSystem.services.printing = {
    enable = lib.mkEnableOption "CUPS printing";
  };

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
  };
}
