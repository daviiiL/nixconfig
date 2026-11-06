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

    home = lib.mkOption {
      type = lib.types.str;
      default = "/home/${host.user}";
      description = "Home directory of the primary user.";
    };

    hashedPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "$6$...";
      description = "Password hash (mkpasswd -m sha-512) set at install; null leaves the password unset.";
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
      inherit (cfg) description home hashedPassword;
      createHome = true;
      extraGroups = ["networkmanager" "wheel" "video" "input"] ++ cfg.extraGroups;
    };
  };
}
