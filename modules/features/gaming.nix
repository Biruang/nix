{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.gaming = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.nixosModules; [];
  in {
    imports = modules;

    boot = {
      kernelParams = [
        # Split lock mitigation disabled.
        "split_lock_mitigate=0"
      ];
      kernel.sysctl = {
        "vm.max_map_count" = 2147483642;
      };
    };

    environment = {
      systemPackages = [
        pkgs.mangohud

        (pkgs.bottles.override {removeWarningPopup = true;})
      ];
      sessionVariables.NIXOS_OZONE_WL = "1";
    };

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      gamemode = {
        enable = true;
      };
      xwayland.enable = true;
    };
  });
}
