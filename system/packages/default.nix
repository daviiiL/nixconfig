{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./fonts.nix
    # ./theme.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _:true;
  };
  environment.systemPackages = with pkgs; [
    git
    neovim
    zsh
    home-manager
  ];
}
