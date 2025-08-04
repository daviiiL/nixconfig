{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    accent = "mauve";
    flavor = "mocha";

    ghostty = {
      enable = true;
      flavor = "mocha";
    };
  };
}
