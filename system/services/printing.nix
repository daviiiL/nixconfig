{
  config,
  lib,
  ...
}: {
  options.localSystem.services.printing = {
    enable = lib.mkEnableOption "CUPS printing";
  };

  config = lib.mkIf config.localSystem.services.printing.enable {
    services.printing.enable = true;
  };
}
