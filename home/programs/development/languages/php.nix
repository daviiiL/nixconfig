{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.development.languages.php;
in {
  options.localHome.programs.development.languages.php.enable =
    lib.mkEnableOption "PHP interpreter";

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.php];
  };
}
