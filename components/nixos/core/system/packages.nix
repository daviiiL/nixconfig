{pkgs, ...}: {
  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    #essentials
    wget
    git
    curl
    lsd
    fzf
    tmux
    util-linux
    usbutils
    #shells
    fish
    zsh
    #dev stuff
    gcc
    nodejs
    python3
    #qol stuff
    libsecret
    home-manager
    powertop
  ];
}
