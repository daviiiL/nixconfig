# { inputs
# , outputs
# , lib
# , config
# , pkgs
# , ...
# }:
{
  imports = [
    ./home.nix
    ./programs
    ./shells
    ./mservices
  ];
}
