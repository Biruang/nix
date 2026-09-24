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

    networking = {
      wireless.enable = true;
      hostName = "homelab";
    };

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
        };
      };
    };
    home-manager.users = {
      "biruang" = self.homeModules.homelabHome;
    };
  };
}
