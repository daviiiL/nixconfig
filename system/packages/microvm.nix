{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.localSystem.packages.microvm;
in {
  imports = [
    inputs.microvm.nixosModules.host
  ];

  options.localSystem.packages.microvm = {
    enable = lib.mkEnableOption "microvm.nix host";
  };

  # upstream defaults this to true
  config.microvm.host.enable = cfg.enable;
}
