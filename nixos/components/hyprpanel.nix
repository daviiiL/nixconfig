{inputs, ...}: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.hyprpanel.overlay
    ];
  };
in {
  environment.systemPackages = with pkgs; [
    hyprpanel
  ];
}
