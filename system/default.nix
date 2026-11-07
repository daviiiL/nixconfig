# hosts only flip toggles, everything for the platform gets imported here.
# split by import instead of mkIf: boot.* doesn't exist on darwin (homebrew.*
# not on nixos), so even disabled definitions fail eval
{
  lib,
  outputs,
  host,
  ...
}: {
  imports =
    {
      nixos = [
        ./cachix
        ./core
        ./disko
        ./hardware
        ./packages
        ./security
        ./services
      ];
      darwin = [./hardware/darwin];
    }
    .${
      host.kind
    };

  nixpkgs = {
    hostPlatform = lib.mkDefault host.system;
    overlays = [outputs.overlays.default];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
