{ pkgs, homeStateVersion, user, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = user;

  system.stateVersion = homeStateVersion;

  #-------------- old -------------------
 
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.niri.enable = true;
}
