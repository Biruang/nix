{ pkgs, homeStateVersion, user, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  networking.hostName = user;

  system.stateVersion = homeStateVersion;
}
