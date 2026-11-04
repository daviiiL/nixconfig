{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.core.network;
in {
  options.localSystem.core.network = {
    enable = lib.mkEnableOption "NetworkManager";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
