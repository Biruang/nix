{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mainConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.mainHardware
      self.nixosModules.niri

      #old and stinky
      #../../../nixos/core
      #../../../nixos/audio
      #../../../nixos/bluetooth
      #../../../nixos/vpn
      #../../../nixos/drivers/amd
      #../../../nixos/drivers/power
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    environment.systemPackages = with pkgs; [
      firefox
      vscode
      #music service from satan(tm)
      yandex-music
      telegram-desktop

      mesa
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      vulkan-tools
    ];

    boot = {
      loader = {
        #timeout = 2;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;

        #grub = {
        #  enable = true;
        #  device = "nodev";
        #  efiSupport = true;
        #};
      };

      initrd.kernelModules = ["amdgpu"];
      kernelParams = ["radeon.si_support=0" "amdgpu.si_support=1"];
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    security.rtkit.enable = true;
    nixpkgs.config = {
      pulseaudio = true;

      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "vscode"
          "yandex-music"
        ];
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    networking = {
      networkmanager.enable = true;
      wireless.enable = true;
    };

    programs.amnezia-vpn = {
      enable = true;
    };

    time.timeZone = "Asia/Tomsk";

    i18n = {
      defaultLocale = "en_US.UTF-8";

      extraLocaleSettings = {
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

    services.xserver.xkb = {
      layout = "us,ru";
      variant = ",";
      options = "grp:alt_shift_toggle";
    };
    console.useXkbConfig = true;

    programs.zsh.enable = true;

    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/biruang/nix";
    };

    users = {
      #defaultUserShell = pkgs.zsh;
      users = {
        biruang = {
          description = "default user";
          isNormalUser = true;
          initialPassword = "111";
          #shell = pkgs.zsh;
          extraGroups = ["wheel" "networkmanager"];
        };
      };
    };

    zramSwap = {
      enable = true;
      algorithm = "lz4";
      memoryPercent = 100;
      priority = 999;
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
    };

    services.xserver.videoDrivers = ["amdgpu"];

    #For Rocm
    systemd.tmpfiles.rules = [
      "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
    ];

    networking.hostName = "main";
    system.stateVersion = "26.05";
  };
}
