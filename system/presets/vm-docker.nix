{lib, ...}: {
  imports = [
    ../packages/docker
    ../packages/microvm.nix
  ];

  localSystem.packages.docker.enable = lib.mkDefault true;
}
