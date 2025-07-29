{
  self,
  pkgs,
  ...
}: {
  imports = [
    ../../system/darwin.nix
  ];

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    primaryUser = "davidas";
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
