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
      self.nixosModules.myHomeManager
      self.nixosModules.mainHardware
      self.nixosModules.docker
      self.nixosModules.openrgb
    ];

    environment = {
      systemPackages = with pkgs; [
        mesa
        #rocmPackages.rocm-smi
        #rocmPackages.rocminfo
        vulkan-tools
        upower
        ddcutil
        #LSP for nix
        nixd
      ];
    };

    fonts.packages = [
      pkgs.nerd-fonts._0xproto
    ];

    programs = {
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/biruang/nix";
      };
      amnezia-vpn.enable = true;
      zsh.enable = true;
      niri.enable = true;
    };

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cache.nixos.org"
        #random binary cache from some dude. secure asf
        "https://niri-epireyn.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      ];
      auto-optimise-store = true;
    };

    #allow satan to your soul EXSPLICITLY
    nixpkgs.config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "yandex-music"
          "telegram-desktop"
        ];
    };

    boot = {
      initrd.kernelModules = ["amdgpu"];
      kernelParams = ["radeon.si_support=0" "amdgpu.si_support=1"];
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
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

    #For Rocm
    systemd.tmpfiles.rules = [
      "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
    ];

    networking = {
      networkmanager.enable = true;
      wireless.enable = true;
      hostName = "main";
    };

    security.rtkit.enable = true;
    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      openssh.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      xserver.videoDrivers = ["amdgpu"];
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
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau-va-gl
          rocmPackages.clr.icd
        ];
      };
      amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
      };
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

    zramSwap = {
      enable = true;
      algorithm = "lz4";
      memoryPercent = 100;
      priority = 999;
    };

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}
