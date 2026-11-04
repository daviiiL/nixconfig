{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.packages.theme;
in {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options.localSystem.packages.theme = {
    enable = lib.mkEnableOption "Catppuccin system theming (TTY)";
  };

  config = lib.mkIf cfg.enable {
    catppuccin.tty.enable = true;
  };
}
