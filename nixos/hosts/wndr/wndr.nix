{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../components/sddm.nix
    ../../components/greetd.nix
    inputs.hyprland.nixosModules.default
  ];
  networking = {
    # system host name
    hostName = "wndr";
    networkmanager.enable = true;
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
        alacritty
        pass
      ];
      shell = pkgs.zsh;
    };
  };
  # boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/43e54fb8-afd1-445f-82d8-bf6e16ed576b";
}
