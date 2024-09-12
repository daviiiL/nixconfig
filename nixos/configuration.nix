{pkgs, ...}: {
  imports = [
    ./components/security.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    # plymouth = {
    #   enable = true;
    #   theme = "bgrt";
    # };
    # initrd.verbose = false;
    # consoleLogLevel = 0;
    # kernelParams = ["quiet" "udev.log_level=0"];
  };

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
    # X11 init.
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    # Printing CUPS
    printing.enable = true;
    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # Keyring
    gnome.gnome-keyring.enable = true;

    # USB
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  programs = {
    hyprland = {
      enable = true;

      # package = inputs.hyprland.packages.${pkgs.system}.default;
      # portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    # keyring seahorse
    dconf.enable = true;
    zsh.enable = true;
  };

  hardware = {
    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.enable = false;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      greetd.enableGnomeKeyring = true;
      gdm-password.enableGnomeKeyring = true;
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "SpaceMono"];})
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # System profile packages
  environment.systemPackages = with pkgs; [
    #editors
    #essentials
    wget
    git
    curl
    tree
    fzf
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
    plymouth
  ];

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      # Set runtime directory
      XDG_RUNTIME_DIR = "/run/user/$UID";
      XDG_PICTURES_DIR = "$HOME/Pictures";
    };
  };
  system.stateVersion = "24.05";
}
