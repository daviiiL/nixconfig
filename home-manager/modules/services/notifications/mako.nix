{lib, ...}: {
  services.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 10000;
    # visual
    backgroundColor = lib.mkForce "#11111bee";
    # borderColor = lib.mkForce "#89b4fa";
    borderColor = lib.mkForce "#11111bee";
    borderRadius = lib.mkForce 10;
    font = "Inter 28pt,Inter 28pt 12";
    padding = "10, 20";
  };
}
