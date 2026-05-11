{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options.localSystem.packages.theme = {
    enable = lib.mkEnableOption "Catppuccin system theming (TTY)";
  };

  config = lib.mkIf config.localSystem.packages.theme.enable {
    catppuccin.tty.enable = true;
  };
}
