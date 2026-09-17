{
  pkgs,
  homeStateVersion,
  user,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
    ./system/core
    ./system/audio
    ./system/bluetooth
    ./system/vpn
  ];

  environment.systemPackages = [pkgs.home-manager];
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  networking.hostName = user;

  home-manager = {
    extraSpecialArgs = {inherit inputs homeStateVersion user;};
    users = {
      "biruang" = import ../home-manager/home.nix;
    };
  };

  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",";
    options = "grp:alt_shift_toggle";
  };
  console.useXkbConfig = true;

  system.stateVersion = homeStateVersion;
}
