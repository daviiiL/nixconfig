{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ripgrep
    gcc
    prettierd
    inputs.nixviii.packages.${pkgs.system}.default
  ];
}
