{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.cachix;
in {
  options.localSystem.cachix = {
    enable = lib.mkEnableOption "Hyprland + nix-community binary caches";
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
