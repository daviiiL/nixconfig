## Hosts

Identity (`user`, `system`, `kind`) for every host is the `hosts` attrset in
`flake.nix`; host files get it as the `host` module argument.

| Host      | dir      | kind  |
| --------- | -------- | ----- |
| desktop   | wndr     | nixos |
| framework | portal   | nixos |
| xps 15    | invictia | nixos |
| intel arc | fae      | nixos |
| non-nixOS | mars     | home  |

## file structure

```filesystem
.
└── hostname
    ├── configuration.nix          # localSystem.* toggles only (flake.nix imports system/ + hardware)
    ├── hardware-configuration.nix
    └── home.nix                   # localHome.* toggles only (flake.nix imports home/)
```
