{lib, ...}: {
  nix.extraOptions = ''
    trusted-users = root chronos
  '';

  security.rtkit.enable = true;
  boot = {
    kernel.sysctl = {
      "kernel.kptr_restrict" = 1;
      "kernel.printk" = "3 3 3 3";

      "dev.tty.ldisc_autoload" = 0;
      "kernel.sysrq" = 4;

      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.tcp_rfc1337" = 1;
      "net.ipv4.conf.all.log_martians" = true;
      "net.ipv4.conf.all.rp_filter" = "1";
      "net.ipv4.conf.default.log_martians" = true;
      "net.ipv4.conf.default.rp_filter" = "1";
      "net.ipv4.icmp_echo_ignore_all" = "1";
      "net.ipv4.conf.all.accept_redirects" = false;
      "net.ipv4.conf.all.secure_redirects" = false;
      "net.ipv4.conf.default.accept_redirects" = false;
      "net.ipv4.conf.default.secure_redirects" = false;
      "net.ipv6.conf.all.accept_redirects" = false;
      "net.ipv6.conf.default.accept_redirects" = false;
      "net.ipv4.conf.all.send_redirects" = false;
      "net.ipv4.conf.default.send_redirects" = false;
      "kernel.yama.ptrace_scope" = 2;
      "net.core.bpf_jit_enable" = false;
      "kernel.ftrace_enabled" = false;
    };

    blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"
      # Old or rare or insufficiently audited filesystems
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
      "cramfs"
      "freevxfs"
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

  # enable firewall
  networking = {
    firewall.enable = true;
  };

  nix.settings.allowed-users = lib.mkDefault ["@users"];

  security = {
    lockKernelModules = lib.mkDefault true;
    protectKernelImage = lib.mkDefault true;

    apparmor = {
      enable = lib.mkDefault true;
      killUnconfinedConfinables = lib.mkDefault true;
    };
  };

  # dunno if needed but here's an antivirus daemon
  # services = {
  #   clamav = {
  #     daemon.enable = true;
  #     updater.enable = true;
  #   };
  # };
}
