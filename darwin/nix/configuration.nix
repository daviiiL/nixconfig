{
  self,
  pkgs,
  # , lib
  inputs,
  ...
}: {
  imports = [
    #import all services
    ./services/default.nix
  ];

  # nix settings for darwin
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    extraOptions = ''
      trusted-users = root rudeus
    '';
    # package = pkgs.nix;
  };

  environment = {
    systemPackages = with pkgs; [
      #nixvim
      inputs.nixvim.packages.${pkgs.system}.default
      tre
    ];
  };

  services.nix-daemon.enable = true;

  security = {
    #NOTE: need to rebuild to reapply after every os update
    pam.enableSudoTouchIdAuth = true;
  };

  programs = {
    zsh.enable = true;
    nix-index.enable = true;
  };

  homebrew = {
    enable = true;
    taps = [
      "FelixKratz/formulae"
    ];
    brews = [
      "coreutils"
      "sketchybar"
      "tre-command"
    ];
    casks = [
      "notchnook"
      "zen-browser"
      "element"
      "sf-symbols"
    ];
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
