{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ../common
    ./ghostty.nix
  ];

  catppuccin = {
    accent = "mauve";
    flavor = "mocha";
  };
}
