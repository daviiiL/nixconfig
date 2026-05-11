{lib, ...}: {
  imports = [
    ./x86-linux-base.nix
    ../hardware
  ];

  localSystem.hardware.laptop.enable = lib.mkDefault true;
}
