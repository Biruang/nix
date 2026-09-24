{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.nvidiaDrivers = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.nixosModules; [];
  in {
    imports = modules;

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        open = false;
        modesetting.enable = true;
        nvidiaSettings = true;
        prime = {
          sync.enable = true;

          # integrated
          intelBusId = "PCI:0:2:0";
          # dedicated
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      nvidia-container-toolkit.enable = true;
    };

    virtualisation.docker.daemon.settings.features.cdi = true;
  });
}
