{lib, ...}: {
  imports = [
    ./x86-linux-base.nix
    ../hardware
  ];

  localSystem.hardware = {
    audio.enable = lib.mkDefault true;
    bluetooth.enable = lib.mkDefault true;
    graphics = {
      enable = lib.mkDefault true;
      amd.enable = lib.mkDefault true;
    };
  };
}
