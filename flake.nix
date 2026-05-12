{
  description = "daviiiL's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

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

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [];

      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;
      };

      flake = let
        inherit (inputs) self nixpkgs home-manager nix-darwin;
        inherit (self) outputs;
        username = "chronos";
      in {
        nixosConfigurations = {
          wndr = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
              user = username;
            };
            modules = [
              ./hosts/wndr/configuration.nix
            ];
          };
          portal = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
              user = username;
            };
            modules = [
              ./hosts/portal/configuration.nix
            ];
          };
          invictia = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
              user = username;
            };
            modules = [
              ./hosts/invictia/configuration.nix
            ];
          };
          fae = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
              user = username;
            };
            modules = [
              ./hosts/fae/configuration.nix
            ];
          };
        };

        darwinConfigurations = {
          neptune = nix-darwin.lib.darwinSystem {
            modules = [
              ./hosts/neptune/configuration.nix
            ];
            specialArgs = {
              inherit inputs self outputs;
            };
          };
        };

        homeConfigurations = {
          "chronos@wndr" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs outputs;
              user = "chronos";
            };
            modules = [
              ./hosts/wndr/home.nix
            ];
          };
          "chronos@portal" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs outputs;
              user = "chronos";
            };
            modules = [
              ./hosts/portal/home.nix
            ];
          };
          "chronos@invictia" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs outputs;
              user = "chronos";
            };
            modules = [
              ./hosts/invictia/home.nix
            ];
          };
          "chronos@fae" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs outputs;
              user = "chronos";
            };
            modules = [
              ./hosts/fae/home.nix
            ];
          };
          "davidas@neptune" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = {inherit inputs outputs;};
            modules = [
              ./hosts/neptune/home.nix
            ];
          };

          "davidl@mars" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {inherit inputs outputs;};
            modules = [
              ./hosts/mars/home.nix
            ];
          };
        };
      };
    };
}
