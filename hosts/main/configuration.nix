{
  pkgs,
  inputs,
  stateVersion,
  user,
  hostname,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    ./hardware-configuration.nix
    ../../nixos/core
    ../../nixos/audio
    ../../nixos/bluetooth
    ../../nixos/vpn
    ../../nixos/drivers/amd
    ../../nixos/drivers/power
  ];

  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    #for Qt wayland support
    libsForQt5.qt5.qtwayland
    qt6Packages.qtwayland
    #LSP for nix
    nixd
    #secure secrets management
    #secretspec
  ];

  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    #rootless docker
    #  rootless = {
    #    enable = true;
    #    setSocketVariable = true;
    #  };
  };
  users.extraUsers.${user}.extraGroups = ["docker"];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "niri-session";
        user = user;
      };
    };
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    #passwordless-sync-users = ["${user}"];
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
    };
  };
  #greeter -> noctalia sync
  #security.polkit = {
  # enable = true;
  # extraConfig = ''
  #    polkit.addRule(function(action, subject) {
  #     var allowedUsers = ["alice"];
  #
  #      if (action.id == "org.noctalia.greeter.sync-appearance" &&
  #         action.lookup("program") == "${pkgs.noctalia-greeter}/bin/noctalia-greeter-apply-appearance" &&
  #         action.lookup("user") == "root" &&
  #          subject.local && subject.active &&
  #          allowedUsers.indexOf(subject.user) >= 0) {
  #        return polkit.Result.YES;
  #     }
  #    });
  #   '';
  # };

  #drive health
  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/disk/by-id/nvme-ADATA_LEGEND_960_2O3329AKK4G9";
      }
    ];
  };

  #portals for niri
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
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
