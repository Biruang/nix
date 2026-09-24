{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.homelabConfig = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      self.nixosModules.homeManager
      self.nixosModules.homelabHardware
      self.nixosModules.core
    ];

    programs = {
      nix-ld.enable = true;
    };

    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };

    networking = {
      networkmanager.enable = true;
      wireless.enable = true;
      hostName = "homelab";
    };

    security.rtkit.enable = true;
    services = {
      #health check
      smartd = {
        enable = true;
        devices = [
          {
            device = "/dev/disk/by-id/nvme-MTFDKBA1T0TFH-1BC1AABHA_UMDMD01J1GBWKE";
          }
        ];
      };
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
      "biruang" = self.homeModules.homelabHome;
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
