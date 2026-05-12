{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.theme.catppuccin;
in {
  config = lib.mkIf cfg.enable {
    catppuccin.ghostty = {
      enable = true;
      flavor = "mocha";
    };
  };
}
