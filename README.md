# daviiiL's nix config

NixOS, nix-darwin and standalone home-manager hosts in one flake.

> the old dotfiles are at [nixconfig-legacy](https://github.com/daviiiL/nixconfig-legacy); the
> darwin config used to live in [nixconfig-darwin](https://github.com/daviiiL/nixconfig-darwin).

> `linux-trim-generations.sh` is from the NixOS wiki.

## overview

```sh
.
├── flake.nix      # inputs + `hosts` attrset (user, system, kind, channel, stateVersion)
├── overlays       # package pins (unstable versions); modules use plain pkgs.<name>
├── hosts          # per-host entry points (see hosts/README.md)
├── system         # `localSystem.*` toggles; NixOS modules by category, darwin ones in system/darwin/
└── home           # home-manager modules, `localHome.*` toggles (see home/README.md)
```

## commands

```sh
nixrebuild    # sudo nixos-rebuild / darwin-rebuild switch (picked per host)
switchhome    # home-manager switch
nixupdate     # nix flake update
nix fmt       # alejandra
```

The zsh functions use the repo you're standing in, falling back to `~/.config/nixconfig`.
New files must be `git add`ed before nix sees them.

## channels

Hosts default to `channel = "stable"` (nixos-25.11 + home-manager release-25.11).
`channel = "unstable"` (neptune) uses nixpkgs-unstable + home-manager master; nix-darwin
always follows unstable. Stable hosts still get selected newer packages through
`overlays/default.nix`.

## recipes

There are no preset modules. Every host file lists its toggles explicitly. These are
the usual combinations to copy from (paths are under `localSystem` / `localHome`).
WMs are the exception: each `wm.*` toggle is a whole session, not a list of apps.

### system (`hosts/<name>/configuration.nix`)

| for | enable | used by |
| --- | --- | --- |
| every NixOS host | `cachix`, `core.{boot,locale,network,settings,shell,user}`, `packages.{core,fonts,microvm}`, `security.linux` (+ `doas`, `apparmor`, `firewall`) | all |
| laptop | `hardware.{laptop,audio,power,bluetooth}` | portal, invictia, fae |
| desktop | `hardware.{audio,bluetooth}` | wndr |
| AMD GPU | `hardware.graphics.amd` | wndr |
| Intel Arc GPU | `hardware.intel-arc` (+ `compute`; `enableGuc = false` if GuC firmware misbehaves) | fae |
| NVIDIA GPU | `hardware.nvidia` (+ `prime` on hybrid laptops), or a nixos-hardware module | invictia (via nixos-hardware) |
| GNOME desktop | `services.gnome.full`, `services.printing` | portal, fae |
| niri | `packages.niri` | portal, fae |
| hyprland | `packages.hyprland` | — |
| containers | `packages.docker` | invictia |
| macOS | `darwin.{settings,defaults,security,packages}`, `darwin.homebrew` (+ `brews`/`casks`) | neptune |

Vendor hardware (Framework, XPS, …) goes in the host's `hardware` list in
`flake.nix` as a [nixos-hardware](https://github.com/NixOS/nixos-hardware) module name.

### home (`hosts/<name>/home.nix`)

| for | enable | used by |
| --- | --- | --- |
| macOS | `platform.darwin.applications` (links GUI apps into ~/Applications) | neptune |
| CLI baseline | `programs.shell.{zsh,starship}`, `programs.cli.{coreutils,claude-code,fastfetch}`, `programs.development.{devenv,languages.php}`, `programs.editors.nixvim`, `programs.documents.zathura` | all |
| desktop baseline | CLI baseline + `programs.development.{gnupg,direnv}`, `programs.editors.vscode`, `programs.terminals.{alacritty,ghostty}`, `programs.browsers.{firefox,chromium}`, `programs.communications.vesktop`, `theme.base` | wndr, portal, invictia, fae |
| GNOME session | `wm.gnome` + `theme.gnome-custom` (or `theme.matugen`) | all desktops |
| hyprland session | `wm.hyprland` (whole session: ags shell, launchers, lock/idle, clipboard, wayland apps) + `theme.matugen` | wndr, portal |
| niri session | `wm.niri` (whole session: quickshell shell, launchers, lock/idle, clipboard, wayland apps) | fae |

> special thanks to fufexan, ryan4yin, and misterio77 for their dotfiles as references.
