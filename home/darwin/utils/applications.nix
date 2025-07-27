# not used
{
  lib,
  pkgs,
  config,
  ...
}: {
  home.activation.darwinApps =
    if pkgs.stdenv.isDarwin
    then let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        HM_APPS="$HOME/Applications/HW Apps"
        [ -e "$HM_APPS" ] && $DRY_RUN_CMD rm -r "$HM_APPS"
        $DRY_RUN_CMD mkdir -p "$HM_APPS"
        $DRY_RUN_CMD cp --archive -H --dereference ${apps}/Applications/* "$HM_APPS"
        $DRY_RUN_CMD chmod +w -R "$HM_APPS"
      ''
    else "";
}
