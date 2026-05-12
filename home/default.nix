{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./wm
    ./theme
    ./platform
  ];

  # Single shared nixpkgs-unstable handle for any leaf that needs bleeding-edge
  # packages. Exposed once at the top of home/ so subtrees don't collide.
  _module.args.unstablePkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
}
