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

    environment = {
      systemPackages = [
        pkgs.mangohud
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
