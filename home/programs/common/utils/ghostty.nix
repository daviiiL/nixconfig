{
  inputs,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable =
      if pkgs.stdenv.isDarwin
      then false
      else true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    package = pkgs.ghostty;
  };
}
