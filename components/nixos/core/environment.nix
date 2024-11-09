{
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
      XDG_PICTURES_DIR = "$HOME/Pictures";
    };
  };
}
