{
  pkgs,
  inputs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  environment.systemPackages = [
    unstable-pkgs.devenv
  ];

  nix.extraOptions = "
      trusted-users = root rudeus 
    ";
}
