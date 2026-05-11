{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series1
  ];

  options.localSystem.hardware.framework = {
    enable = lib.mkEnableOption "Framework laptop (Intel Core Ultra) — implies laptop preset";
  };

  config = lib.mkIf config.localSystem.hardware.framework.enable {
    localSystem.hardware.laptop.enable = lib.mkDefault true;
  };
}
