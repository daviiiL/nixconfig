{
  description = "daviiiL's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    nixviii.url = "github:daviiiL/nixviii";

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:microvm-nix/microvm.nix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    lix-module,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    username = "chronos";
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

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
          lix-module.nixosModules.default
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
          lix-module.nixosModules.default
        ];
      };
    };

    darwinConfigurations = {
      neptune = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/neptune/configuration.nix
          lix-module.nixosModules.default
        ];
        specialArgs = {
          inherit inputs self outputs;
        };
      };
    };

    homeConfigurations = {
      "chronos@wndr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/wndr/home.nix
        ];
      };
      "chronos@portal" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/portal/home.nix
        ];
      };
      "chronos@invictia" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/invictia/home.nix
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
}
