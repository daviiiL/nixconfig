{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.localHome.programs.cli.networking;
in {
  options.localHome.programs.cli.networking.enable =
    lib.mkEnableOption "networking utilities (ngrok, iperf3, telnet)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ngrok
      iperf3
      (runCommand "telnet" {} ''
        mkdir -p $out/bin $out/share/man/man1
        ln -s ${inetutils}/bin/telnet $out/bin/telnet
        ln -s ${inetutils.man}/share/man/man1/telnet.1.gz $out/share/man/man1/telnet.1.gz
      '')
    ];
  };
}
