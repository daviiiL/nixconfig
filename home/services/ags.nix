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
    sassc
    playerctl
    libnotify
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
