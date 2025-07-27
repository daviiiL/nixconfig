{...}: {
  environment.systemPackages = [
    # inputs.nixviii.packages.${pkgs.system}.default
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  security = {
    #NOTE: need to rebuild to reapply after every os update
    pam.services.sudo_local.touchIdAuth =
      true;
  };
}
