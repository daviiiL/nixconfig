## daviii's nixos flake

> configs are slowly being migrated from `$HOME/.configs` to `home-manager`

[nixos](https://nixos.org/)
[home-manager](https://github.com/nix-community/home-manager)

## recent changelogs

- migrated home-manager from nixosModules to standalone
- organized nixvim config following elythh's awesome template

## credits

- [elythh](https://github.com/elythh/nixvim)'s nixvim template
- [fufexan](https://github.com/fufexan/dotfiles)'s ags module
- [Misterio77](https://github.com/Misterio77/nix-starter-configs)'s flake template for easier organization

### dotfiles

- dotfiles are managed as git submodules:
  - first time after cloning down the repo: git submodule update --init --recursive
  - update to the latest commit head: git submodule update --recursive --remote

### note to self :

- for ags: symblink from `/path/to/ags` to `~/.config/ags` for now
