# home/

home-manager configuration, mirrors `system/`'s `localSystem.*` options pattern as `localHome.*`.

## Layout

- `programs/` — cross-platform programs grouped by what they are
  (`shell/`, `editors/`, `terminals/`, `browsers/`, `development/`, `communications/`, `cli/`)
- `wm/` — desktop sessions / window managers (`hyprland/`, `niri/`, `gnome/`)
- `theme/` — theming (`base/` foundation, `catppuccin/`, `matugen/`, `gnome-custom/`)
- `platform/` — platform-specific glue that isn't a "program" (e.g. Darwin `/Applications` symlink)
- `presets/` — host-class bundles that flip groups of `localHome.*` toggles
  (`linux-desktop.nix`, `linux-laptop.nix`, `macbook.nix`, `minimal-cli.nix`)

## Conventions

Every leaf declares `options.localHome.<path>.enable` (matching its directory path)
and gates its body with `lib.mkIf cfg.enable`. Hosts compose by flipping toggles:

```nix
imports = [
  ../../home
  ../../home/presets/linux-laptop.nix
];

localHome = {
  wm.hyprland.enable = true;
  theme.matugen.enable = true;
};
```

Cross-module dependencies flip the other module's toggle with `lib.mkDefault`
inside their own `config` block (e.g. `theme/matugen` defaults
`theme.base.enable = true`).

## Carve-outs

Some programs are intentionally **not** managed by home-manager so `matugen` can
rewrite their configs at runtime — don't migrate those into home-manager.
