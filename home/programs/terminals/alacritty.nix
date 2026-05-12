{
  config,
  lib,
  ...
}: let
  cfg = config.localHome.programs.terminals.alacritty;
in {
  options.localHome.programs.terminals.alacritty.enable =
    lib.mkEnableOption "alacritty terminal";

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;

      settings = {
        font = {
          size = 12;
        };

        window = {
          padding = {
            x = 10;
            y = 10;
          };
        };

        colors = {
          primary = {
            background = "#000000";
          };
        };
      };
    };
  };
}
