# Imports every system module for the host's platform; hosts only flip toggles.
# Platforms are split by import, not mkIf: options like boot.* don't exist on
# darwin (and homebrew.* not on NixOS), so even disabled definitions would fail.
{
  outputs,
  host,
  ...
}: {
  imports =
    {
      nixos = [
        ./cachix
        ./core
        ./hardware
        ./packages
        ./security
        ./services
      ];
      darwin = [./darwin];
    }
    .${
      host.kind
    };

  nixpkgs = {
    overlays = [outputs.overlays.default];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
