{inputs, ...}: {
  imports = [
    ./laptop.nix
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series1
  ];
}
