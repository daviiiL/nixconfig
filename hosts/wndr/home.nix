{
  inputs,
  # outputs,
  # config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/programs
    ../../home/services
    ../../home/theme
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "chronos";
    homeDirectory = "/home/chronos";
    packages = [
      # inputs.nixvim.packages.${pkgs.system}.default
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  # reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
