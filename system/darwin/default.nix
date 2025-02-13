{...}: {
  environment.systemPackages = [
    # inputs.nixviii.packages.${pkgs.system}.default
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  services.nix-daemon.enable = true;

  security = {
    #NOTE: need to rebuild to reapply after every os update
    pam.enableSudoTouchIdAuth = true;
  };
}
