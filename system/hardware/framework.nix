{inputs, ...}: {
  imports = [
    ./audio.nix
    ./power.nix
    ./bluetooth.nix
    inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series1
  ];
}
