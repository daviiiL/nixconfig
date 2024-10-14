{
  description = "daviiiL's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland";

    nixvim.url = "github:daviiiL/nixvim";

    ags.url = "github:Aylur/ags";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin but for nix!
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lix-module,
    catppuccin,
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
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      wndr = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
          ./nixos/hosts/wndr/wndr.nix
          lix-module.nixosModules.default
          catppuccin.nixosModules.catppuccin
        ];
      };
      wndrportal =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./nixos/configuration.nix
            ./nixos/hosts/wndrportal/wndrportal.nix
            lix-module.nixosModules.default
            catppuccin.nixosModules.catppuccin
          ];
        };
      nvictus =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./nixos/configuration.nix
            ./nixos/hosts/nvictus/nvictus.nix
            lix-module.nixosModules.default
          ];
        };
    };

    homeConfigurations = {
      "rudeus@wndr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/wndr.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
      "rudeus@wndrportal" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/wndrportal.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
      "rudeus@nvictus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/nvictus.nix
          # {wayland.windowManager.hyprland.enable = true;}
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
