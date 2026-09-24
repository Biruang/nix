{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mainConfiguration = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.homeManager
      self.nixosModules.mainHardware
      self.nixosModules.docker
      self.nixosModules.openrgb
      self.nixosModules.amdDrivers
      self.nixosModules.core
    ];

    programs = {
      amnezia-vpn.enable = true;
      niri.enable = true;
    };

    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        #random binary cache from some dude. secure asf
        "https://niri-epireyn.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      ];
    };

    #allow satan to your soul EXSPLICITLY
    nixpkgs.config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "yandex-music"
          "telegram-desktop"
          "vscode"
          "vscode-extension-ms-vscode-remote-remote-ssh"
        ];
    };

    #portals for niri
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "*";
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    networking = {
      networkmanager.enable = true;
      wireless.enable = true;
      hostName = "main";
    };

    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          session.default = "niri";
          user.default = "biruang";
          cursor.size = 24;
          appearance = {
            scheme = "Synced";
            password_style = "default";
            hide_logo = true;
            scheme_selector_position = "hidden";
            power_buttons_position = "bottom-right";
          };
        };
        passwordless-sync-users = ["biruang"];
      };

      #health check
      smartd = {
        enable = true;
        devices = [
          {
            device = "/dev/disk/by-id/nvme-ADATA_LEGEND_960_2O3329AKK4G9";
          }
        ];
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      i2c.enable = true;
    };

    users = {
      defaultUserShell = pkgs.zsh;
      users = {
        "biruang" = {
          isNormalUser = true;
          description = "biruang";
          extraGroups = ["networkmanager" "wheel"];
          packages = with pkgs; [
            #  thunderbird
          ];
        };
      };
    };
    home-manager.users = {
      "biruang" = self.homeModules.biruangModule;
    };

    time.timeZone = "Asia/Tomsk";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };
}
