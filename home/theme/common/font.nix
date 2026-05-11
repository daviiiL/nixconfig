{pkgs, ...}: {
  gtk = {
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
      size = 11;
    };
  };
}
