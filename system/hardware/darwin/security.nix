{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.darwin.security;
in {
  options.localSystem.darwin.security = {
    enable = lib.mkEnableOption "Darwin hardening (SSH disabled, Touch ID for sudo)";
  };

  config = lib.mkIf cfg.enable {
    services.openssh.enable = false;
    security.pam.services.sudo_local.touchIdAuth = true;
  };
}
