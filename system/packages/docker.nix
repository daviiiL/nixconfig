{
  user,
  inputs,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = [
    inputs.compose2nix.packages.x86_64-linux.default
  ];
  # NOTE: the user needs to be added to the docker group to run docker without sudo
  users.users.${user}.extraGroups = ["docker"];
}
