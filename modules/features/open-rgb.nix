{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.openrgb = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.nixosModules; [];
  in {
    imports = modules;
    services.hardware.openrgb = {
      enable = true;
      package = self'.packages.myOpenrgb;
      motherboard = "amd";
    };
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myOpenrgb = pkgs.openrgb;
  };
}
