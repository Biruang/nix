{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.core = {
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.nixosModules; [];
  in {
    imports = modules;

    environment = {
      systemPackages = with pkgs; [
        ghostty.terminfo
        upower
        ddcutil
        #LSP for nix
        nixd
      ];
    };

    networking = {
      networkmanager.enable = true;
    };

    fonts.packages = [
      pkgs.nerd-fonts._0xproto
    ];

    programs = {
      nix-ld.enable = true;
      nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/home/biruang/nix";
      };
      zsh.enable = true;
    };

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;

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

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      openssh.enable = true;
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
