{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.terminals.ghostty;
in {
  options.localHome.programs.terminals.ghostty.enable =
    lib.mkEnableOption "ghostty terminal";

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = !pkgs.stdenv.isDarwin;
      enableFishIntegration = true;
      enableZshIntegration = true;
      installVimSyntax = true;
      package = pkgs.ghostty;

      settings.confirm-close-surface = false;
    };
  };
}
