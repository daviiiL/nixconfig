{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./components/security.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      outputs.overlays.additions
    ];
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "America/New_York";

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
      audio.enable = true;
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
    # notify
    systembus-notify.enable = true;

    # # replaces gettys
    # kmscon = {
    #   enable = true;
    #   # hwRender = true;
    #   extraConfig = "
    #     font-size=18
    #     ";
    # };
    # mouse support in tty virtual console
    # gpm.enable = true;
  };

  systemd = {
    #enable emergency mode when something goes wrong
    enableEmergencyMode = true;

    # greetd disable error messages on screen
    services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };

  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    # pipewire enabled
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

  # System profile packages
  environment.systemPackages = with pkgs; [
    #essentials
    wget
    git
    curl
    lsd
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
    powertop
    mako
    tmux
  ];

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
      XDG_PICTURES_DIR = "$HOME/Pictures";
    };
  };
  system.stateVersion = "24.05";
}
