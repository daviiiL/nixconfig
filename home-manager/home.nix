{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
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
      zoom-us
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
      # config.wayland.windowManager.hyprland.package
      hyprpaper
      hyprlock
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
      #lsp&formatter
      typescript
      alejandra
      prettierd
      black
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
      btop
      stress
      s-tui
      lm_sensors
      corectrl
      glxinfo
      # qoa 
      todoist-electron
      pavucontrol
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
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
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
