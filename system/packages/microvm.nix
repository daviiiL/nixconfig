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

  # Upstream defaults microvm.host.enable to true; drive it from our toggle.
  config.microvm.host.enable = cfg.enable;
}
