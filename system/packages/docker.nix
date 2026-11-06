{
  config,
  host,
  inputs,
  lib,
  pkgs,
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
      # pinned to 29 for security fixes
      package = pkgs.docker_29;
      rootless = lib.mkIf cfg.rootless {
        enable = true;
        setSocketVariable = true;
      };
    };

    environment.systemPackages = [
      inputs.compose2nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    users.users.${host.user}.extraGroups = ["docker"];
  };
}
