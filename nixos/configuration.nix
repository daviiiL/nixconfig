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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "wndr"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
    xserver.enable = true;
    displayManager.sddm.enable = true;
    # X11 configs.
    xserver = {
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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Keyring
    gnome.gnome-keyring.enable = true;
  };

  programs.seahorse.enable = true;

  # Enable Hyprland
  # programs.hyprland = {
  #   enable = true;
  # };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security = {
    rtkit.enable = true;
    pam.services.greetd.enableGnomeKeyring = true;
  };

  #user definition
  users.users.rudeus = {
    name = "rudeus";
    home = "/home/rudeus/";
    isNormalUser = true;
    description = "David Liu";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #browser
      firefox
      #dev tools
      gh
      #window manager and stuff
      # hyprland
      hyprlock
      hypridle
      #terminal
      kitty
      #app launcher
      anyrun
      #tools
      wdisplays
      nerdfonts
      #keyring
      pass
    ];
    shell = pkgs.zsh;
  };

  #fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "SpaceMono" ]; })
    ];
  };

  #zsh shell config.
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "eastwood";
      plugins = [ ];
    };
    shellAliases = {
      la = "eza --icons -la";
      ls = "eza --icons";
      rebuildsystem = "cd ~/nixconfig && sudo nixos-rebuild switch --flake .#wndr";
      switchhome = "cd ~/nixconfig && home-manager switch --flake .#rudeus@wndr";
      cdgit = "cd ~/Documents/git";
      cdproj = "cd ~/Documents/git/curProj";
      code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

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
    eza
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
    NIXOS_OZONE_WL = "2";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
