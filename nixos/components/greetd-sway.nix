{pkgs, ...}: let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --cmd sway --theme container=black;border=yellow;input=yellow";
        user = "greeter";
      };
    };
  };
}
