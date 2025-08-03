{
  imports = [
    ./audio.nix
    ./power.nix
    ./bluetooth.nix
  ];

  # Enable libinput for mouse and touchpad support
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
    };
    touchpad = {
      tapping = true;
      naturalScrolling = true;
    };
  };
}
