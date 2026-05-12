{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.development.android;
in {
  options.localHome.programs.development.android.enable =
    lib.mkEnableOption "Android tooling (android-tools, android-studio-full on Linux)";

  config = lib.mkIf cfg.enable {
    home.packages =
      [pkgs.android-tools]
      ++ lib.optional (!pkgs.stdenv.isDarwin) pkgs.android-studio-full;
  };
}
