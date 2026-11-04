# home/

home-manager configuration, mirrors `system/`'s `localSystem.*` options pattern as `localHome.*`.

## Layout

- `programs/<category>/<tool>.nix` — one file per tool (or small related bundle)
  (`shell/`, `editors/`, `terminals/`, `browsers/`, `development/`, `communications/`,
  `cli/`, `documents/`). Interchangeable groups get a folder:
  `development/languages/<lang>.nix`
- `wm/` — whole desktop sessions, one toggle each: `hyprland/` (+ ags), `niri/`
  (+ quickshell), `gnome/`. `wayland.nix` is the userland shared by hyprland and
  niri (launchers, lock/idle, clipboard, apps) and has no toggle of its own
- `theme/` — theming (`base/` foundation, `catppuccin.nix`, `matugen.nix`, `gnome-custom/`)
- `platform/` — OS-specific glue (`darwin-applications.nix`)
- `default.nix` — imports everything and holds the shared host boilerplate
  (identity from the `host` arg, allowUnfree, overlays, stateVersion)

## Conventions

Every leaf declares `options.localHome.<path>.enable` (matching its file path, e.g.
`programs/cli/ripgrep.nix` → `localHome.programs.cli.ripgrep`) and gates its body
with `lib.mkIf cfg.enable`. Modules use plain `pkgs.<name>`; unstable pins live in
`overlays/default.nix`. `flake.nix` imports `home/` for every host; host files
only flip toggles (common combinations: "recipes" in the root README).

A module may `lib.mkDefault`-enable another only when it can't work without it
(e.g. `theme/matugen` → `theme.base`, `editors/nixvim` → `cli.ripgrep`). Bundles
of "usually wanted together" belong in the README recipes, not in modules.

## Carve-outs

Some programs are intentionally **not** managed by home-manager so `matugen` can
rewrite their configs at runtime — don't migrate those into home-manager.
