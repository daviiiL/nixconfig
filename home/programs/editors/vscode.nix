{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.editors.vscode;
in {
  options.localHome.programs.editors.vscode.enable =
    lib.mkEnableOption "VS Code";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      profiles.default = {
        enableUpdateCheck = true;
        enableExtensionUpdateCheck = true;
      };
    };
  };
}
