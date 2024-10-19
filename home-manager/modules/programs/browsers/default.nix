{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # ./firefox.nix
    # ./chrome.nix
  ];

  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
