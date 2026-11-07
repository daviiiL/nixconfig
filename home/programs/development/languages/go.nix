{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.development.languages.go;
in {
  options.localHome.programs.development.languages.go.enable =
    lib.mkEnableOption "Go toolchain";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      go
    ];
  };
}
