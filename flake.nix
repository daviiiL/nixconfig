{
  description = "daviiiL's dotfiles flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # hm
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # wm
    hyprland.url = "git+https://github.com/hyprwm/Hyprland";
    hyprlock.url = "github:hyprwm/hyprlock";

    # neovim
    nixvim.url = "github:daviiiL/nixvim";

    # aylurs gtk shell
    ags.url = "github:Aylur/ags";
    hyprpanel.url = "github:daviiiL/HyprPanel";

    # browsers
    zen-browser.url = "github:fufexan/zen-browser-flake";

    # theming
    catppuccin.url = "github:catppuccin/nix";

    # disabled
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    lanzaboote,
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
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    nixosConfigurations = {
      wndr = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/wndr/configuration.nix
          lanzaboote.nixosModules.lanzaboote
          catppuccin.nixosModules.catppuccin
        ];
      };
      wndrportal =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./hosts/wndrportal/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            catppuccin.nixosModules.catppuccin
          ];
        };
      # nvictus =
      #   nixpkgs.lib.nixosSystem
      #   {
      #     specialArgs = {inherit inputs outputs;};
      #     modules = [
      #       ./nixos/configuration.nix
      #       ./nixos/hosts/nvictus/nvictus.nix
      #       lix-module.nixosModules.default
      #     ];
      #   };
    };

    # darwinConfigurations = {
    #   neptune = nix-darwin.lib.darwinSystem {
    #     modules = [
    #       ./darwin/nix/configuration.nix
    #
    #       home-manager.darwinModules.home-manager
    #       {
    #         home-manager = {
    #           users.rudeus = import ./darwin/home-manager/darwin-home.nix;
    #           extraSpecialArgs = {
    #             inherit inputs;
    #           };
    #         };
    #         users.users.rudeus = {
    #           name = "rudeus";
    #           home = "/Users/rudeus";
    #         };
    #       }
    #     ];
    #     specialArgs = {
    #       inherit inputs self outputs;
    #     };
    #   };
    # };
    #
    homeConfigurations = {
      "rudeus@wndr" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/wndr/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
      "rudeus@wndrportal" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/wndrportal/home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
      # "rudeus@nvictus" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
      #   extraSpecialArgs = {inherit inputs outputs;};
      #   modules = [
      #     ./home-manager/hosts/nvictus.nix
      #     # {wayland.windowManager.hyprland.enable = true;}
      #     catppuccin.homeManagerModules.catppuccin
      #   ];
      # };
    };
  };
}
