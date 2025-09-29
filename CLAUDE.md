# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is daviiiL's NixOS configuration repository using Nix Flakes. The configuration supports multiple hosts (both NixOS and Darwin) with modular system and home configurations.

## Core Commands

### Formatting
```bash
# Format all Nix files using alejandra formatter
nix fmt
```

### Building and Switching
```bash
# Build and switch NixOS configuration
sudo nixos-rebuild switch --flake .#<hostname>

# Build and switch Darwin configuration (macOS)
darwin-rebuild switch --flake .#<hostname>

# Build and switch home-manager configuration
home-manager switch --flake .#<user>@<hostname>
```

### Generation Management
```bash
# Clean up old generations using the provided script
./trim-generations.sh

# Manual generation cleanup with custom parameters
./trim-generations.sh <keep-generations> <keep-days> <profile>
```

### Flake Operations
```bash
# Update flake inputs
nix flake update

# Show flake outputs
nix flake show

# Check flake
nix flake check
```

## Repository Architecture

### Directory Structure
```
.
├── flake.nix          # Main flake configuration
├── hosts/             # Per-host configurations
│   ├── wndr/          # Desktop (x86_64-linux)
│   ├── portal/        # Framework laptop (x86_64-linux)
│   ├── invictia/      # XPS 15 laptop (x86_64-linux)
│   ├── neptune/       # MacBook (aarch64-darwin)
│   └── mars/          # Non-NixOS host (home-manager only)
├── system/            # NixOS system configurations
│   ├── core/          # Core system settings (boot, locale, network, etc.)
│   ├── hardware/      # Hardware-specific modules
│   ├── packages/      # System package configurations
│   ├── presets/       # System presets for different machine types
│   ├── security/      # Security configurations
│   └── services/      # System services
└── home/              # Home Manager configurations
    ├── darwin/        # Darwin-specific home configurations
    ├── programs/      # Program configurations organized by type
    └── theme/         # Theming configurations
```

### Key Flake Inputs
- `nixpkgs`: Main package repository (25.05 stable)
- `nixpkgs-unstable`: Unstable packages when needed
- `home-manager`: User environment management
- `nix-darwin`: macOS system management
- `catppuccin`: Catppuccin theme integration
- `ags`/`quickshell`: Shell/bar configurations
- `nixviii`: Custom Neovim configuration
- `lix-module`: Alternative Nix implementation

### Host Configurations

| Host | Type | Platform | Description |
|------|------|----------|-------------|
| wndr | Desktop | x86_64-linux | Desktop system |
| portal | Laptop | x86_64-linux | Framework laptop |
| invictia | Laptop | x86_64-linux | XPS 15 |
| neptune | Laptop | aarch64-darwin | MacBook |
| mars | Non-NixOS | x86_64-linux | Home-manager only |

### Modular System Design

The configuration uses a highly modular approach:

- **System presets**: `system/presets/` contains base configurations for different machine types (desktop, laptop, macbook)
- **Hardware modules**: `system/hardware/` handles hardware-specific configurations (nvidia, bluetooth, audio, etc.)
- **Program organization**: `home/programs/` separates programs by desktop environment (common, hyprland, niri, gnome)
- **Theming**: Centralized theme management in `home/theme/` with support for dynamic colorscheme generation

### Special Features

- **Dynamic theming**: Some programs are excluded from home-manager for dynamic colorscheme generation
- **Multi-platform support**: Configurations for both Linux (NixOS) and macOS (Darwin)
- **Wayland compositors**: Support for Hyprland, Niri, and GNOME
- **Development environments**: Android development, various programming languages
- **Container support**: Docker configurations with compose2nix integration

### Development Workflow

When making changes:
1. Test locally with `nixos-rebuild switch --flake .#<hostname>` or appropriate command
2. Format code with `nix fmt` before committing
3. Use `nix flake check` to validate the flake
4. Update flake lock with `nix flake update` when updating inputs

### Username Convention
The default username is `chronos` for Linux hosts and varies for Darwin hosts (see flake.nix for specific mappings).