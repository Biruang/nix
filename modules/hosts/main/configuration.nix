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
    ];

    system.stateVersion = "26.05";

    #flake support
    nix.settings.experimental-features = ["nix-command" "flakes"];

    environment.sessionVariables = rec {
      TERMINAL = "alacritty";
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
      ];
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    networking.hostName = "main";
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;

    #programs.nh = {
    #  enable = true;
    #  clean.enable = true;
    #  clean.extraArgs = "--keep-since 4d --keep 3";
    #  flake = "/home/${user}/nix";
    #};

    #for LSP to correct align input path with flake
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    zramSwap = {
      enable = true;
      algorithm = "lz4";
      memoryPercent = 100;
      priority = 999;
    };

    programs.amnezia-vpn = {
      enable = true;
    };

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      #temp
      telegram-desktop
      vscode
      firefox
      pavucontrol

      amnezia-vpn
      #for Qt wayland support
      libsForQt5.qt5.qtwayland
      qt6Packages.qtwayland
      #LSP for nix
      nixd
      #secure secrets management
      #secretspec
    ];
  };
}
