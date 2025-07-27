{
  self,
  pkgs,
  ...
}: {
  imports = [
    ../../system/darwin
  ];
  nix.enable = false;

  system.configurationRevision = self.rev or self.dirtyRev or null;
  security.pam.services.sudo_local.touchIdAuth = true;

  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
