{
  description = "daviiiL's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    catppuccin.url = "github:catppuccin/nix";

    #darwin for the win...macos
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #standalone home-manager: avoid nixos rebuilds for userspace changes
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #for laptops
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    #ags scaffolding for astal; setup with home manager without bundling
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # neovim
    nixviii.url = "github:daviiiL/nixviii";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
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
    };

    darwinConfigurations = {
      Neptune = nix-darwin.lib.darwinSystem {
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
      "davidliu@Neptune" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/neptune/home.nix
        ];
      };
    };
  };
}
