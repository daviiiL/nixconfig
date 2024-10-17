{lib, ...}: {
  services.mako = {
    enable = true;
    anchor = "top-right";
    # visual
    backgroundColor = lib.mkForce "#11111bee";
    borderColor = lib.mkForce "#B4BEFE";
    borderRadius = lib.mkForce 10;
    font = "SpaceMono Nerd Font 10";
    padding = "10, 20";
  };
}
