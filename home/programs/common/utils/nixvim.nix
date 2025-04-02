{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ripgrep
    inputs.nixviii.packages.${pkgs.system}.default
  ];
}
