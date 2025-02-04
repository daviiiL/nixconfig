{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./fonts.nix
  ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    neovim
    zsh
  ];
}
