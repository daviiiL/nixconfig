{
  description = "daviiiL's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # For hosts on channel = "unstable" (home-manager master tracks nixpkgs-unstable).
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Homebrew: nix-homebrew installs and pins the prefix; taps are pinned as
    # non-flake inputs so `brew tap` is never needed.
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-speedtest = {
      url = "github:teamookla/homebrew-speedtest";
      flake = false;
    };

    # opencode 2.2.5 has a darwin node_modules hash mismatch; drop once fixed upstream.
    nixpkgs-opencode.url = "github:nixos/nixpkgs/aa48d347080940b8a2b8d2f48228674e280a3514";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.quickshell.follows = "quickshell";
    };

    nixviii.url = "github:daviiiL/nixviii";

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:microvm-nix/microvm.nix";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}: let
    # Machine identity; passed to host and module files as `host`
    # ({name, user, system, kind, channel, stateVersion, hardware}).
    #   kind: "nixos" | "darwin" get a system config; "home" is home-manager only.
    #   channel: "stable" (nixos-25.11) or "unstable" (nixpkgs-unstable + HM master).
    #   stateVersion: home-manager (and NixOS) state version; never lower it.
    #   hardware: nixos-hardware module names (imports can't be toggled by options).
    hosts = {
      wndr = {
        user = "chronos";
        system = "x86_64-linux";
        kind = "nixos";
      };
      portal = {
        user = "chronos";
        system = "x86_64-linux";
        kind = "nixos";
        hardware = ["framework-intel-core-ultra-series1"];
      };
      invictia = {
        user = "chronos";
        system = "x86_64-linux";
        kind = "nixos";
        hardware = ["dell-xps-15-9530-nvidia"];
      };
      fae = {
        user = "chronos";
        system = "x86_64-linux";
        kind = "nixos";
      };
      neptune = {
        user = "davidliu";
        system = "aarch64-darwin";
        kind = "darwin";
        channel = "unstable";
        stateVersion = "26.05";
      };
      mars = {
        user = "davidl";
        system = "x86_64-linux";
        kind = "home";
      };
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };

      flake = let
        inherit (inputs) self nixpkgs nixpkgs-unstable home-manager home-manager-unstable nix-darwin;
        inherit (self) outputs;
        inherit (nixpkgs) lib;

        withDefaults = name: h:
          {
            inherit name;
            channel = "stable";
            stateVersion = "25.11";
            hardware = [];
          }
          // h;
        allHosts = lib.mapAttrs withDefaults hosts;
        hostsOfKind = kind: lib.filterAttrs (_: h: h.kind == kind) allHosts;

        channels = {
          stable = {
            pkgs = nixpkgs;
            hm = home-manager;
          };
          unstable = {
            pkgs = nixpkgs-unstable;
            hm = home-manager-unstable;
          };
        };

        specialArgs = host: {inherit inputs self outputs host;};
      in {
        overlays.default = import ./overlays {inherit inputs;};

        nixosConfigurations = lib.mapAttrs (name: host:
          channels.${host.channel}.pkgs.lib.nixosSystem {
            specialArgs = specialArgs host;
            modules =
              [
                ./system
                ./hosts/${name}/hardware-configuration.nix
                ./hosts/${name}/configuration.nix
              ]
              ++ map (m: inputs.nixos-hardware.nixosModules.${m}) host.hardware;
          })
        (hostsOfKind "nixos");

        darwinConfigurations = lib.mapAttrs (name: host:
          nix-darwin.lib.darwinSystem {
            specialArgs = specialArgs host;
            modules = [
              inputs.nix-homebrew.darwinModules.nix-homebrew
              ./system
              ./hosts/${name}/configuration.nix
            ];
          })
        (hostsOfKind "darwin");

        homeConfigurations = lib.mapAttrs' (name: host:
          lib.nameValuePair "${host.user}@${name}" (channels.${host.channel}.hm.lib.homeManagerConfiguration {
            pkgs = channels.${host.channel}.pkgs.legacyPackages.${host.system};
            extraSpecialArgs = specialArgs host;
            modules = [
              ./home
              ./hosts/${name}/home.nix
            ];
          }))
        allHosts;
      };
    };
}
