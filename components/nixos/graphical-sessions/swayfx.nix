{
  inputs,
  pkgs,
  ...
}: {
  programs.sway = {
    enable = true;
    package = inputs.nixpkgs.legacyPackages.${pkgs.system}.swayfx;
    wrapperFeatures.gtk = true;
  };
}
