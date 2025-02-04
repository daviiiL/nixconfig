{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    brightnessctl
    brillo
    wl-clipboard
    fuzzel
    sassc
    # upower
    blueberry
    gnome-control-center
  ];

  programs.ags = {
    enable = true;
    configDir = null;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      astal3
      io
      battery
      bluetooth
      hyprland
      mpris
      network
      notifd
      wireplumber
      tray
    ];
  };
}
