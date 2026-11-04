{
  config,
  lib,
  host,
  ...
}: let
  cfg = config.localSystem.core.user;
in {
  options.localSystem.core.user = {
    enable = lib.mkEnableOption "the primary user account (host.user)";

    description = lib.mkOption {
      type = lib.types.str;
      default = host.user;
      description = "GECOS description of the primary user.";
    };

    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Groups added on top of networkmanager/wheel/video/input.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${host.user} = {
      isNormalUser = true;
      inherit (cfg) description;
      extraGroups = ["networkmanager" "wheel" "video" "input"] ++ cfg.extraGroups;
    };
  };
}
