{pkgs, ...}: {
  fonts.packages = with pkgs; [
    inter-nerdfont
    noto-fonts
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
