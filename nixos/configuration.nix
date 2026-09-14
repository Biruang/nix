{ pkgs, homeStateVersion, user, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  environment.systemPackages = [ pkgs.home-manager ];

  networking.hostName = user;

  system.stateVersion = homeStateVersion;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa ];
  };

  #-------------- old -------------------
 
  # Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "us";
  #  variant = "";
  #};
}
