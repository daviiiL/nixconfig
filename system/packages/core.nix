{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.packages.core;
in {
  options.localSystem.packages.core = {
    enable = lib.mkEnableOption "core system packages (git, neovim, home-manager CLI)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      neovim
      home-manager
    ];
  };
}
