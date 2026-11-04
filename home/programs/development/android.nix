{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.development.android;
in {
  options.localHome.programs.development.android.enable =
    lib.mkEnableOption "Android tooling (android-tools, android-studio-full)";

  config = lib.mkIf cfg.enable {
    nixpkgs.config.android_sdk.accept_license = true;

    home.packages = with pkgs; [
      android-tools
      android-studio-full
    ];
  };
}
