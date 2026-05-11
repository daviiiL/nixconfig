{
  config,
  lib,
  ...
}: let
  cfg = config.localSystem.security.linux;
in {
  options.localSystem.security.linux = {
    enable = lib.mkEnableOption "Linux hardening (kernel sysctls, module blacklist, AppArmor, firewall)";
    doas = lib.mkEnableOption "doas instead of sudo";
    apparmor = lib.mkEnableOption "AppArmor with kill-unconfineds";
    firewall = lib.mkEnableOption "nftables firewall";
  };

  config = lib.mkIf cfg.enable {
    nix.extraOptions = ''
      trusted-users = root chronos
    '';
    nix.settings.allowed-users = lib.mkDefault ["@users"];

    security = {
      rtkit.enable = true;
      doas.enable = cfg.doas;
      protectKernelImage = lib.mkDefault true;
      apparmor = lib.mkIf cfg.apparmor {
        enable = lib.mkDefault true;
        killUnconfinedConfinables = lib.mkDefault true;
      };
    };

    boot = {
      kernel.sysctl = {
        "kernel.kptr_restrict" = 1;
        "kernel.printk" = "3 3 3 3";
        "dev.tty.ldisc_autoload" = 0;
        "kernel.sysrq" = 4;
        "kernel.yama.ptrace_scope" = 2;
        "net.core.bpf_jit_enable" = false;
        "kernel.ftrace_enabled" = false;
      };

      blacklistedKernelModules = [
        "ax25"
        "netrom"
        "rose"
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2fs"
        "vivid"
        "gfs2"
        "ksmbd"
        "nfsv4"
        "nfsv3"
        "cifs"
        "nfs"
        "jffs2"
        "hfs"
        "hfsplus"
        "squashfs"
        "udf"
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
      ];
    };

    networking.firewall.enable = cfg.firewall;
  };
}
