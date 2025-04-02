{pkgs, ...}: {
  gtk = {
    font = {
      name = "fira-code-nerdfont";
      package = pkgs.fira-code-nerdfont;
      size = 11;
    };
  };
}
