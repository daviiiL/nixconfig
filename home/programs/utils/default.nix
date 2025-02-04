{
  inputs,
  pkgs,
  ...
}:
# let
#   unstable-pkgs = import inputs.nixpkgs-unstable {
#     system = pkgs.system;
#     config.allowUnfree = true;
#   };
# in
{
  home.packages = with pkgs; [
    #dev
    gh

    #wm
    anyrun
    fuzzel
    wl-clipboard
    swww
    yad
    bc
  ];
}
