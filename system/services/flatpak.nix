{
  config,
  lib,
  ...
}: {
  options.localSystem.services.flatpak = {
    enable = lib.mkEnableOption "Flatpak";
  };

  config = lib.mkIf config.localSystem.services.flatpak.enable {
    services.flatpak.enable = true;
  };
}
