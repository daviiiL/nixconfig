{
  config,
  user,
  inputs,
  lib,
  ...
}: let
  cfg = config.localSystem.packages.docker;
in {
  options.localSystem.packages.docker = {
    enable = lib.mkEnableOption "Docker daemon and compose2nix";
    rootless = lib.mkEnableOption "rootless Docker";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      rootless = lib.mkIf cfg.rootless {
        enable = true;
        setSocketVariable = true;
      };
    };

    environment.systemPackages = [
      inputs.compose2nix.packages.x86_64-linux.default
    ];

    users.users.${user}.extraGroups = ["docker"];
  };
}
