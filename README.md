# daviiiL's nix config

Machine specific Nix config flake.

## history

This repo has been restructured enough times to have ancestors:

- [nixconfig-legacy](https://github.com/daviiiL/nixconfig-legacy): prev nix dotfiles.
- [nixconfig-darwin](https://github.com/daviiiL/nixconfig-darwin): old darwin dotfiles 

`linux-trim-generations.sh` is grabbed from the official nix website 

## hosts

| host | desc | category |
| --- | --- | --- |
| wndr | desktop build 015 | nixos |
| portal | FW13 Pro | nixos |
| invictia | XPS 15 | nixos |
| fae | Laptop | nixos |
| neptune | MBP | darwin |
| mars | nix manager on arch | home |

## layout

```sh
.
├── flake.nix      # inputs, hosts attrset 
├── overlays       # package pins 
├── hosts          # per-host entrypoint
├── system         # sys-level 
└── home           # userspace home manager
```

## commands

```sh
nixrebuild    # sudo nixos-rebuild/darwin-rebuild switch 
nixupdate     # nix flake update
switchhome    # home-manager switch
nix fmt       # alejandra
```

The first three are zsh functions. Subs in the nixconfig location when ran; falls back to `~/.config/nixconfig`

## channels

Stable channels mostly for all hosts, except nix-darwin builds are on unstable.
`overlays/default.nix` defines all the overlays for the package exceptions. 

## modules

Each module is an `enable` toggle under `localSystem.*` (`system/`) or `localHome.*` (`home/`).
No presets; host files set toggles explicitly.

### system

| category | covers |
| --- | --- |
| core | boot, locale, network, nix settings, shell, user |
| hardware | laptop, audio, power, bluetooth, integrated and discrete graphics |
| packages | core, fonts, theme, microvm, docker, niri, hyprland |
| security | doas, apparmor, firewall |
| services | gnome, printing, greetd, flatpak, input methods, webcam |
| darwin | settings, defaults, security, packages, homebrew |
| cachix | binary caches |

Vendor hardware goes in the host's `hardware` list in `flake.nix` as a
[nixos-hardware](https://github.com/NixOS/nixos-hardware) module name.

### home

| category | covers |
| --- | --- |
| programs | shell, cli, editors, terminals, browsers, development, communications, documents |
| wm | full sessions: gnome, hyprland (ags), niri (quickshell) |
| theme | base, catppuccin, matugen, gnome-custom |
| platform | darwin GUI app linking |

Conventions: `home/README.md`.

## credits

fufexan, ryan4yin, and misterio77.
Specific docs are generated with the help of anthropic.
