{user, ...}: {
  virtualisation.docker.enable = true;

  # NOTE: the user needs to be added to the docker group to run docker without sudo
  users.users.${user}.extraGroups = ["docker"];
}
