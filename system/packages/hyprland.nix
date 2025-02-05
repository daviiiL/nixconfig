{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kitty
    hyprcursor
  ];

  programs.hyprland = {
    enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
