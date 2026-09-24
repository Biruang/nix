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
      self.nixosModules.gaming
      self.nixosModules.amdDrivers
      self.nixosModules.desktop
    ];

    #allow satan to your soul EXSPLICITLY
    nixpkgs.config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "yandex-music"
          "telegram-desktop"
          "vscode"
          "vscode-extension-ms-vscode-remote-remote-ssh"
          "steam"
          "steam-original"
          "steam-unwrapped"
          "steam-run"
        ];
    };

    networking = {
      wireless.enable = true;
      hostName = "main";
    };

    services = {
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
      "biruang" = self.homeModules.biruangModule;
    };
  };
}
