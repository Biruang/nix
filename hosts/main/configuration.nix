{
  pkgs,
  stateVersion,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../nixos/core
    ../../nixos/audio
    ../../nixos/bluetooth
    ../../nixos/vpn
    ../../nixos/drivers/amd
    ../../nixos/drivers/power
  ];

  environment.systemPackages = [pkgs.home-manager];
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    XDG_BIN_HOME = "$HOME/.local/bin";
    # Optional, hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Hint for QT apps to use wayland with xcd fallback
    QT_QPA_PLATFORM = "wayland;xcb";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  networking.hostName = hostname;

  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",";
    options = "grp:alt_shift_toggle";
  };
  console.useXkbConfig = true;

  system.stateVersion = stateVersion;
}
