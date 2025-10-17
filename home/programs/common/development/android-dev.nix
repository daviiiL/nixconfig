{pkgs, ...}: {
  home.packages =
    if pkgs.stdenv.isDarwin
    then [pkgs.android-tools]
    else [
      pkgs.android-tools
      pkgs.android-studio-full
    ];
}
