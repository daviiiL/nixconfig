{
  inputs,
  pkgs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  home.packages = with pkgs; [
    # essentials
    git
    neofetch
    zip
    xz
    unzip
    p7zip
    xdg-utils
    gh
    nerdfonts
    gnome.seahorse
    libnotify
    alsa-utils
    playerctl
    gnome.nautilus
    gnome.gnome-calendar

    # communications
    vesktop
    unstable-pkgs.zoom-us
    element-desktop

    # lsps & formatters
    typescript
    alejandra
    prettierd
    black
    isort
    jq
    stylua
    shellcheck
    shfmt
    shellharden
    bicep
    nil
    nixd

    # editors
    inputs.nixvim.packages.${pkgs.system}.default
    unstable-pkgs.zed-editor
    helix

    # hardware related
    stress
    s-tui
    lm_sensors
    corectrl
    glxinfo

    # productivity & entertainment
    todoist-electron
    pavucontrol
    spotify
    obsidian
    zathura

    # clipboard management
    wofi
    cliphist
  ];
}
