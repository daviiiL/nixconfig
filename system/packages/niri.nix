{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # kitty
    # hyprcursor
    niri
    ghostty
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
