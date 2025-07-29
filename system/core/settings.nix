{
  pkgs,
  lib,
  ...
}: {
  nix = {
    optimise.automatic = true;
    settings.experimental-features = ["nix-command" "flakes"];

    gc = lib.mkIf pkgs.stdenv.isLinux {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
  };
}
