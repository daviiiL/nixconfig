{pkgs, ...}: {
  imports = [
    ./gnome-services.nix
    ./printing.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (oldAttrs: {
        # GNOME dynamic triple buffering (huge performance improvement)
        # See https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441
        # Also https://gitlab.gnome.org/vanvugt/mutter/-/tree/triple-buffering-v4-47
        src = final.fetchFromGitLab {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-47";
          hash = "sha256-6n5HSbocU8QDwuhBvhRuvkUE4NflUiUKE0QQ5DJEzwI=";
        };

        # GNOME 47 requires the gvdb subproject which is not included in the triple-buffering branch
        # This copies the necessary gvdb files from the official GNOME repository
        preConfigure = let
          gvdb = final.fetchFromGitLab {
            domain = "gitlab.gnome.org";
            owner = "GNOME";
            repo = "gvdb";
            rev = "2b42fc75f09dbe1cd1057580b5782b08f2dcb400";
            hash = "sha256-CIdEwRbtxWCwgTb5HYHrixXi+G+qeE1APRaUeka3NWk=";
          };
        in ''
          cp -a "${gvdb}" ./subprojects/gvdb
        '';
      });
    })
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
    };
  };
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-contacts
    gnome-logs
    gnome-software
  ];
}
