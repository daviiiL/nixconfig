{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.services.flatpak;
in {
  options.localSystem.services.flatpak = {
    enable = lib.mkEnableOption "Flatpak";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
