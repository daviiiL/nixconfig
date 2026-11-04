{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localSystem.packages.fonts;
in {
  options.localSystem.packages.fonts = {
    enable = lib.mkEnableOption "system fonts (Inter, Noto CJK, Liberation, Fira Code, Mplus, etc.)";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      inter-nerdfont
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];

    fonts.fontconfig.defaultFonts = {
      sansSerif = ["Inter" "Noto Sans CJK SC"];
      serif = ["Liberation Serif" "Noto Serif CJK SC"];
      monospace = ["Fira Code" "Noto Sans Mono CJK SC"];
    };
  };
}
