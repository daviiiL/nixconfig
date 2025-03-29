{
  # nixpkgs.allowUnfreePredicate = _:true;

  imports = [
    ./utils
    ./browser
    ./shell
    ./communications
  ];
}
