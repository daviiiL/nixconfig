{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kitty
    hyprcursor
  ];

  programs.hyprland = {
    enable = true;
  };
}
