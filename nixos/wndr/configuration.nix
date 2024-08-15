# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable flakes and nix-cmd
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # might slow down builds in exchange of store being auto matically optimized; 
    # alternatively, can run garbage collector at internals 
    auto-optimise-store = true;
  };

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    # system host name 
    hostName = "wndr";
    networkmanager.enable = true;
  };

  # Set your time zone.
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
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      # X11 configs.
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
  # programs!!!
  programs = {
    #hyprland
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    # keyring seahorse
    seahorse.enable = true;
    zsh.enable = true;
  };

  # Enable sound with pipewire.
  hardware = {
    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.enable = false;
  };

  security = {
    rtkit.enable = true;
    pam.services = {
      greetd.enableGnomeKeyring = true;
      gdm-password.enableGnomeKeyring = true;
    };
  };

  #user definition
  users = {
    defaultUserShell = pkgs.zsh;
    users.rudeus = {
      name = "rudeus";
      home = "/home/rudeus/";
      isNormalUser = true;
      description = "David Liu";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        alacritty
        pass
      ];
      shell = pkgs.zsh;
    };
  };

  #fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "SpaceMono" ]; })
    ];
  };

  # Allow unfree packages
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
  ];

  environment.variables = {
    # Set runtime directory
    XDG_RUNTIME_DIR = "/run/user/$UID";
    # Set ozone flag
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "24.05";
}
