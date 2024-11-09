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
  programs = {
    btop = {
      enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      icons = true;
    };
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = "  ";
        };
        modules = [
          "OS"
          "Kernel"
          "CPU"
          "Display"
          "Shell"
          "WM"
          "Colors"
        ];
      };
    };
  };

  home.packages = with pkgs; [
    neofetch
    # font
    nerdfonts
    # git & github
    git
    gh
    # compression
    zip
    xz
    unzip
    p7zip
    # communications
    vesktop
    unstable-pkgs.zoom-us
    element-desktop
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
  ];
}
