{
  self,
  host,
  ...
}: {
  localSystem.darwin = {
    settings.enable = true;
    defaults.enable = true;
    security.enable = true;
    packages.enable = true;
    homebrew = {
      enable = true;
      brews = [
        "neovim"
        "teamookla/speedtest/speedtest"
      ];
    };
  };

  networking.hostName = host.name;

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    primaryUser = host.user;
  };

  nixpkgs.hostPlatform = host.system;
  # nix-darwin's own state version (an integer, unrelated to host.stateVersion).
  system.stateVersion = 6;
}
