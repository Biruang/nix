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
      self.nixosModules.docker
      self.nixosModules.core
    ];

    powerManagement.enable = true;

    networking = {
      wireless.enable = true;
      hostName = "homelab";
    };

    services = {
      thermald.enable = true;
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

    specialisation = {
      nvidia.configuration = {
        services.xserver.videoDrivers = ["nvidia"];
        hardware.graphics.enable = true;
        hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
        hardware.nvidia.modesetting.enable = true;
        hardware.nvidia.prime = {
          sync.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };
      };
    };

    users = {
      defaultUserShell = pkgs.zsh;
      users = {
        "biruang" = {
          isNormalUser = true;
          description = "biruang";
          extraGroups = ["networkmanager" "wheel"];
        };
      };
    };
    home-manager.users = {
      "biruang" = self.homeModules.homelabHome;
    };
  };
}
