{
  stateVersion,
  user,
  ...
}: {
  imports = [
    ../../home-manager/modules
    ../../home-manager/packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = stateVersion;
    keyboard = null;
  };
}
