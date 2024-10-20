{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../components/hyprland.nix
    ../../components/sddm.nix
    ../../components/greetd.nix
    ../../components/gaming.nix
    ../../components/tty.nix
    ../../components/dev.nix
    inputs.hyprland.nixosModules.default
  ];
  networking = {
    # system host name
    hostName = "wndr";
    networkmanager.enable = true;
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = "
        font-size=18
        ";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.rudeus = {
      name = "rudeus";
      home = "/home/rudeus/";
      isNormalUser = true;
      description = "David Liu";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        foot
        pass
        helix
      ];
      shell = pkgs.zsh;
    };
  };
}
