{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.communications;
in {
  options.localHome.programs.communications.enable =
    lib.mkEnableOption "communications apps (vesktop)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
