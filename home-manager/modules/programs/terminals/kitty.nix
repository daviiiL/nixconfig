{
  inputs,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.kitty;
    font = {
      name = "FiraMono Nerd";
    };
    settings = {
      window_padding_width = 10;
      placement_strategy = "center";
      confirm_os_window_close = 0;
      update_check_interval = 0;
    };
  };
}
