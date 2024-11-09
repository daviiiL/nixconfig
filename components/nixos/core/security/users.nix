{lib, ...}: {
  nix.settings.allowed-users = lib.mkDefault ["@users"];
}
