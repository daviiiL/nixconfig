{
  imports = [
    ./boot.nix
    ./locale.nix
    ./network.nix
    ./shell.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
