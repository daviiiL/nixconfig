{lib, ...}: {
  imports = [
    ./extensions.nix
    ./configurations.nix
  ];

  options.localHome.wm.gnome.enable =
    lib.mkEnableOption "GNOME desktop userland (extensions, dconf, tweaks)";
}
