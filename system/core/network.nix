{
  config,
  lib,
  ...
}: {
  options.localSystem.core.network = {
    enable = lib.mkEnableOption "NetworkManager";
  };

  config = lib.mkIf config.localSystem.core.network.enable {
    networking.networkmanager.enable = true;
  };
}
