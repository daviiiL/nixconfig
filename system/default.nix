# Imports every NixOS module. Hosts import this plus one preset; nothing else
# imports leaf modules directly.
{outputs, ...}: {
  imports = [
    ./cachix
    ./core
    ./hardware
    ./packages
    ./security
    ./services
  ];

  nixpkgs = {
    overlays = [outputs.overlays.default];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
