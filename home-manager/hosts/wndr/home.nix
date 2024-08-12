# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../../programs
    ../../shells
    ../../services
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };
  home = {
    username = "rudeus";
    homeDirectory = "/home/rudeus";
    packages = with pkgs; [
      #communications
      vesktop
      #tools
      neofetch
      zip
      xz
      unzip
      p7zip
      xdg-utils
      gh
      wdisplays
      nerdfonts
      #wm specifics
      config.wayland.windowManager.hyprland.package
      hyprpaper
      hyprlock
      hypridle
      anyrun
      ripgrep
      wl-clipboard
      #lsp&formatter
      typescript
      alejandra
      prettierd
      black
      #editors
      vscode-fhs
      zed-editor
      inputs.nixvim.packages.${pkgs.system}.default
      #ags dependencies 
      coreutils
      dart-sass
      gawk
      imagemagick
      procps
      ripgrep
      util-linux
      gnome.gnome-control-center
      mission-center
      overskride
      wlogout
      #devbox
      devbox
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  programs.zsh.shellAliases = {
    la = "eza -la";
    ls = "eza";
    code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    nixrebuild = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndr";
    switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndr";
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
