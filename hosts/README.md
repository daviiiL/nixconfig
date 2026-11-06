## Hosts

Identity (`user`, `system`, `kind`, plus optional `channel`, `stateVersion`,
`hardware`) for every host is the `hosts` attrset in `flake.nix`; host files get it
as the `host` module argument.

| Host                | dir      | kind   |
| ------------------- | -------- | ------ |
| desktop build 015   | wndr     | nixos  |
| FW13 Pro            | portal   | nixos  |
| XPS 15              | invictia | nixos  |
| Laptop              | fae      | nixos  |
| MBP                 | neptune  | darwin |
| nix manager on arch | mars     | home   |

## file structure

```filesystem
.
└── hostname
    ├── configuration.nix          # localSystem.* toggles only (flake.nix imports system/ + hardware)
    ├── hardware-configuration.nix # nixos hosts; optional (no fileSystems when localSystem.disko is on)
    └── home.nix                   # localHome.* toggles only (flake.nix imports home/)
```
