{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # some stuff that should have come with no matter what
    git
    neovim
  ];
}
