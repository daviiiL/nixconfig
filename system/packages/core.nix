{
  config,
  lib,
  pkgs,
  ...
}: {
  options.localSystem.packages.core = {
    enable = lib.mkEnableOption "core system packages (git, neovim, home-manager CLI)";
  };

  config = lib.mkIf config.localSystem.packages.core.enable {
    environment.systemPackages = with pkgs; [
      git
      neovim
      home-manager
    ];
  };
}
