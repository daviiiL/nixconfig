{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
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

  catppuccin = {
    enable = true;
    accent = "sapphire";
    flavor = "mocha";
  };

  home = {
    username = "rudeus";
    homeDirectory = "/home/rudeus";
    packages = with pkgs; [
      unstable-pkgs.zed-editor
      git
      #communications
      vesktop
      unstable-pkgs.zoom-us
      element-desktop
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
      # dconf
      #wm specifics
      hyprpaper
      unstable-pkgs.hyprlock
      hypridle
      hyprpicker
      hyprshot
      # hyprlandPlugins.hyprexpo
      anyrun
      grim
      slurp
      mako
      ripgrep
      wl-clipboard
      swww
      waypaper
      nwg-look
      qt6ct
      qt5ct
      #lsp&formatter
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
      #editors
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
      # hardware related
      # btop
      stress
      s-tui
      lm_sensors
      corectrl
      glxinfo
      # qoa
      todoist-electron
      pavucontrol
      spotify
      obsidian
      wofi
      cliphist
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  home.file = {
    ".config/anyrun" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/submodules/anyrun";
      recursive = true;
    };
    ".config/ags" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/home-manager/services/ags";
      recursive = true;
    };
    ".config/wofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/submodules/wofi";
      recursive = true;
    };
  };

  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 11;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "catppuccin-mocha-sapphire-compact";
      package = pkgs.catppuccin-gtk.override {
        # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/data/themes/catppuccin-gtk/default.nix
        accents = ["sapphire"];
        size = "compact";
        variant = "mocha";
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs = {
    home-manager.enable = true;
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
