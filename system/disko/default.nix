# fresh installs only. gpt, esp on /boot, rest is luks2 -> btrfs @ @home @nix,
# swapfile in @swap. passphrase comes from /tmp/disko-password, see README
{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.disko;

  subvol = mountpoint: {
    inherit mountpoint;
    mountOptions = ["compress=zstd" "noatime"];
  };

  rootFs = {
    type = "btrfs";
    extraArgs = ["-f"];
    subvolumes =
      {
        "@" = subvol "/";
        "@home" = subvol "/home";
        "@nix" = subvol "/nix";
      }
      // lib.optionalAttrs (cfg.swapSizeGiB != null) {
        "@swap" = {
          mountpoint = "/.swap";
          swap.swapfile.size = "${toString cfg.swapSizeGiB}G";
        };
      };
  };
in {
  options.localSystem.disko = {
    enable = lib.mkEnableOption "declarative disk layout (disko)";

    device = lib.mkOption {
      type = lib.types.str;
      example = "/dev/disk/by-id/nvme-...";
      description = "Whole disk to install to; wiped on format.";
    };

    swapSizeGiB = lib.mkOption {
      type = lib.types.nullOr lib.types.ints.positive;
      default = 32;
      description = "Swapfile size in GiB, or null for no swap.";
    };
  };

  config = lib.mkIf cfg.enable {
    disko.devices.disk.main = {
      type = "disk";
      inherit (cfg) device;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["fmask=0077" "dmask=0077"];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              passwordFile = "/tmp/disko-password";
              settings.allowDiscards = true;
              content = rootFs;
            };
          };
        };
      };
    };
  };
}
