# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

daviiiL's NixOS / nix-darwin / home-manager configuration as a single Nix flake. Pins `nixpkgs` and `home-manager` to `25.11` (see `flake.nix`, `hosts/state-version.nix`). Built with `flake-parts`; the formatter is `alejandra`.

## Core Commands

```bash
# Format all Nix files (alejandra, wired via flake-parts perSystem.formatter)
nix fmt

# Build & switch — pick the matching command for the target
sudo nixos-rebuild switch --flake .#<hostname>          # wndr | portal | invictia
darwin-rebuild switch --flake .#<hostname>              # neptune
home-manager switch --flake .#<user>@<hostname>         # chronos@{wndr,portal,invictia}, davidas@neptune, davidl@mars

# Validate / inspect the flake
nix flake check
nix flake show
nix flake update

# Trim old generations (script lives at repo root, NOT named trim-generations.sh)
./linux-trim-generations.sh                              # interactive, defaults to 5 gens / 5 days
./linux-trim-generations.sh <keep-gens> <keep-days> <profile>   # profile: user | home-manager | channels | system
```

## Architecture

### The `localSystem.*` options pattern (the central abstraction)

Every module under `system/` follows the same shape: declare a feature option under the `localSystem.*` namespace, gate its body with `lib.mkIf`. Hosts compose by **flipping toggles**, not by importing leaf modules directly. Example:

```nix
# system/services/greetd.nix declares: options.localSystem.services.greetd.enable
# system/presets/x86-linux-base.nix imports ../services (which imports all leaf modules)
# A host then writes:
localSystem.services.greetd.enable = true;
```

Consequences when editing:
- **Adding a new module** under `system/` requires both writing the `options.localSystem.*` schema *and* adding it to the appropriate `default.nix` aggregator (e.g. `system/services/default.nix`). It will not auto-load.
- **Cross-module implications** are wired by having one module set another's `localSystem.*` toggle (with `lib.mkDefault`) inside its own `config` block — see `system/hardware/framework.nix` enabling `localSystem.hardware.laptop`, and `system/services/gnome-full.nix` enabling `gnome.services` + `printing`.
- **Two host styles coexist**: `portal` uses the toggle style (`localSystem.services.gnome.full.enable = true`); `wndr` directly imports `system/services/gnome-full.nix`. Both work; prefer toggles for new hosts.

### Preset hierarchy

Hosts import exactly one preset:
- `system/presets/x86-linux-base.nix` — cachix, core, packages.core+fonts, security.linux defaults
- `system/presets/x86-linux-desktop.nix` — base + hardware (audio, bluetooth, graphics.amd)
- `system/presets/x86-linux-laptop.nix` — desktop + laptop power/lid tweaks
- `system/presets/macbook.nix` — Darwin equivalent

Hardware specializations (e.g. `framework.nix`) layer on top via their own `localSystem.hardware.*.enable` toggle.

### Host → user mappings (from `flake.nix`)

| Host | System type | Home-manager user |
|------|-------------|-------------------|
| wndr | nixosSystem (x86_64-linux) | `chronos@wndr` |
| portal | nixosSystem (x86_64-linux, Framework) | `chronos@portal` |
| invictia | nixosSystem (x86_64-linux, XPS 15) | `chronos@invictia` |
| neptune | darwinSystem (aarch64-darwin) | `davidas@neptune` |
| mars | (no system config, non-NixOS) | `davidl@mars` |

`hosts/<name>/configuration.nix` is the system entry point; `hosts/<name>/home.nix` is the per-host home-manager entry. `hardware-configuration.nix` is **gitignored** — each machine has its own.

### Home-manager layout

`home/programs/{common,gnome,hyprland,niri}` group programs by desktop environment. Each host's `home.nix` imports whichever subsets apply. `home/theme/` holds theming: `catppuccin`, `matugen` (dynamic colorscheme generation), `gnome-custom`, `common`. Some programs are intentionally **not** managed by home-manager so `matugen` can rewrite their configs at runtime — don't migrate those into home-manager.

### Shared state version

All NixOS/home-manager hosts read `hosts/state-version.nix` (currently `"25.11"`) via `import ../state-version.nix`. Bump this single file when migrating across NixOS releases; do not hardcode versions per host.

## Known constraints & gotchas

- **`system/packages/theme.nix` is opt-in** — explicitly excluded from `system/packages/default.nix` because its `gtk` submodule references `services.displayManager.generic`, which only exists in `nixpkgs-unstable` and breaks 25.11 evaluation. Hosts that want catppuccin theming must import it directly.
- **`hardware-configuration.nix` is gitignored** — never commit it; per-host hardware files stay local.
- **Always run `nix fmt` before committing.** alejandra is the formatter set by `perSystem.formatter`; CI/`nix flake check` will surface unformatted files.

## Active flake inputs

`nixpkgs` (25.11), `nixpkgs-unstable`, `home-manager` (release-25.11), `nix-darwin`, `nixos-hardware`, `flake-parts`, `catppuccin`, `ags`, `quickshell`, `nixviii` (custom Neovim from `github:daviiiL/nixviii`), `compose2nix`, `microvm`.
