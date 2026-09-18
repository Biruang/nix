{
  inputs,
  stateVersion,
  user,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
    ../../home/noctalia.nix
    ../../home/niri.nix
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
