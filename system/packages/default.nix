{pkgs, ...}: {
  imports = [
    ./hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    neovim
    zsh
  ];
}
