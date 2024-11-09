{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./source
  ];
  services.mako.enable = lib.mkForce false;

  home.packages = with pkgs; [
    coreutils
    dart-sass
    gawk
    imagemagick
    procps
    ripgrep
    util-linux
    gnome.gnome-control-center
    mission-center
    overskride
    wlogout
    sway-contrib.grimshot
  ];

  home.file = {
    ".config/ags" = {
      source = config.lib.file.mkOutOfStoreSymlink ./source;
      recursive = true;
    };
  };
}
