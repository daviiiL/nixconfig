{pkgs, ...}: {
  fonts.packages = with pkgs; [
    inter-nerdfont
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = ["Inter" "Noto Sans CJK SC"];
      serif = ["Liberation Serif" "Noto Serif CJK SC"];
      monospace = ["Fira Code" "Noto Sans Mono CJK SC"];
    };
  };
}
