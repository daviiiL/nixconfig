{
  config,
  lib,
  unstablePkgs,
  ...
}: let
  cfg = config.localHome.programs.cli.coreutils;
in {
  options.localHome.programs.cli.coreutils.enable =
    lib.mkEnableOption "everyday CLI bag (gh, devenv, claude-code, eza, btop, fzf, zip, …)";

  config = lib.mkIf cfg.enable {
    home.packages = with unstablePkgs; [
      gh
      devenv
      claude-code
      php

      zathura

      eza
      btop
      fzf
      xdg-utils
      zip
      unzip
    ];
  };
}
