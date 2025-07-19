{pkgs, ...}: {
  imports = [
    ./niri.nix
    ./fonts.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  environment.systemPackages = with pkgs; [
    git
    neovim
    zsh
    home-manager
  ];
}
