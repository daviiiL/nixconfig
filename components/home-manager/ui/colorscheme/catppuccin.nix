{
  pkgs,
  lib,
  ...
}: {
  catppuccin = {
    enable = lib.mkDefault true;
    accent = "sapphire";
    flavor = "mocha";
  };

  qt.style.catppuccin.enable = true;

  gtk.theme = {
    name = "catppuccin-mocha-sapphire-compact";
    package = pkgs.catppuccin-gtk.override {
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/data/themes/catppuccin-gtk/default.nix
      accents = ["sapphire"];
      size = "compact";
      variant = "mocha";
    };
  };

  programs = {
    helix.catppuccin.enable = lib.mkDefault true;
    tmux.catppuccin.enable = lib.mkDefault true;
    foot.catppuccin.enable = lib.mkDefault true;
    kitty.catppuccin.enable = lib.mkDefault true;
    btop.catppuccin.enable = lib.mkDefault true;
  };
}
