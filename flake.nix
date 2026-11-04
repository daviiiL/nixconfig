{
  description = "daviiiL's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    # Machine identity; passed to host files as `host` ({name, user, system, kind}).
    # kind "nixos" also gets a nixosConfiguration; "home" is home-manager only.
    # hardware: nixos-hardware module names (imports can't be toggled by options).
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
        inherit (inputs) self nixpkgs home-manager;
        inherit (self) outputs;
        inherit (nixpkgs) lib;

        withName = name: h: h // {inherit name;};
        hostsOfKind = kind: lib.filterAttrs (_: h: h.kind == kind) hosts;
      in {
        overlays.default = import ./overlays {inherit inputs;};

        nixosConfigurations = lib.mapAttrs (name: h:
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
              host = withName name h;
            };
            modules =
              [
                ./system
                ./hosts/${name}/hardware-configuration.nix
                ./hosts/${name}/configuration.nix
              ]
              ++ map (m: inputs.nixos-hardware.nixosModules.${m}) (h.hardware or []);
          })
        (hostsOfKind "nixos");

        homeConfigurations = lib.mapAttrs' (name: h:
          lib.nameValuePair "${h.user}@${name}" (home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${h.system};
            extraSpecialArgs = {
              inherit inputs outputs;
              host = withName name h;
            };
            modules = [
              ./home
              ./hosts/${name}/home.nix
            ];
          }))
        hosts;
      };
    };
}
