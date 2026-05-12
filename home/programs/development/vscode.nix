{
  config,
  lib,
  unstablePkgs,
  ...
}: let
  cfg = config.localHome.programs.development.vscode;
in {
  options.localHome.programs.development.vscode.enable =
    lib.mkEnableOption "VS Code";

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = unstablePkgs.vscode;

      profiles.default = {
        enableUpdateCheck = true;
        enableExtensionUpdateCheck = true;
      };
    };
  };
}
