{
  pkgs,
  # inputs,
  ...
}: {
  imports = [
    # ../programs/shell
    # ../programs/utils/nixvim.nix
  ];

  home.packages = with pkgs; [
    devenv
  ];
}
