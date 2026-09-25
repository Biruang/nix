{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.homelabConfig = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.homeManager
      self.nixosModules.homelabHardware
      self.nixosModules.nvidiaDrivers
      self.nixosModules.docker
      #self.nixosModules.core
      self.nixosModules.desktop
    ];

    environment.systemPackages = [];

    powerManagement.enable = true;

    networking = {
      wireless.enable = true;
      hostName = "homelab";
    };

    nixpkgs.config.allowUnfree = true;
    #nixpkgs.config.allowUnfreePredicate = pkg:
    #  builtins.elem (lib.getName pkg) [
    #    "nvidia-x11"
    #    "nvidia-settings"
    #    "nvidia-persistenced"
    #  ];

    services = {
      thermald.enable = true;

      tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

          #Optional helps save long term battery health
          START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
          STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
        };
      };

      #health check
      smartd = {
        enable = true;
        devices = [
          {
            device = "/dev/disk/by-id/nvme-MTFDKBA1T0TFH-1BC1AABHA_UMDMD01J1GBWKE";
          }
        ];
      };

      xserver.videoDrivers = ["nvidia"];
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
