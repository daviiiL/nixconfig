{...}: {
  environment.systemPackages = [
    # inputs.nixviii.packages.${pkgs.system}.default
  ];
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      loginwindow.SHOWFULLNAME = true;
    };
  };

  system = {
    primaryUser = "davidas";
    startup.chime = true;
    defaults = {
      trackpad = {
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  services = {
    openssh.enable = true;
  };

  security = {
    #NOTE: need to rebuild to reapply after every os update
    pam.services.sudo_local.touchIdAuth =
      true;
  };
}
