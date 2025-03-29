{
  nixpkgs.config.allowUnfreePredicate = _:true;

  imports = [
    ./utils
    ./browser
    ./shell
    ./communications
  ];
}
