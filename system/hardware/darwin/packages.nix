{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.darwin.packages;
in {
  options.localSystem.darwin.packages = {
    enable = lib.mkEnableOption "core system packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      home-manager
    ];
  };
}
