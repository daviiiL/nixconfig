{lib, ...}: {
  imports =
    builtins.filter
    (file: baseNameOf file != "default.nix")
    (lib.filesystem.listFilesRecursive ./.);
}
