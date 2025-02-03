{
  imports = [
    ./boot.nix
    ./locale.nix
    ./network.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
