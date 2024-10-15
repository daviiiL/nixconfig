## daviii's nixos flake

> must be cloned to the user home directory for dotfiles to correctly populate

[nixos](https://nixos.org/)
[home-manager](https://github.com/nix-community/home-manager)

## TODO:

- [ ] hyprland plugins for 0.44
- [ ] migrate matugen dotfile into hm

## recent changelogs

- dotfiles migration complete
- back to nixos from distro hopping. home sweet home.
- updated nixvim dependencies
- updated hyprland to latest
- most necessary dotfiles are now managed by the home manager
- switched to Lix from the core nix language
- included the new nixvim flake based on dc-tec's nixvim config
- migrated home-manager from nixosModules to standalone

## credits

- [elythh](https://github.com/elythh/nixvim)'s nixvim template for a noice ui
- [dc-tec](https://github.com/dc-tec/nixvim)'s nixvim configs for the keymaps n plugins that i dig
- [fufexan](https://github.com/fufexan/dotfiles)'s ags module clean and functional
- [Misterio77](https://github.com/Misterio77/nix-starter-configs)'s flake template for easier organization

## dotfiles

> FETCH SUBMODULES FIRST

- dotfiles are managed as git submodules:
  - first time after cloning down the repo: `git submodule update --init --recursive`
  - update to the latest commit head: `git submodule update --recursive --remote`
