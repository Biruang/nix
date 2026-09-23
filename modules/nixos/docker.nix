{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.docker = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.nixosModules; [];
  in {
    imports = modules;
    virtualisation.docker = {
      enable = true;
      package = self'.packages.myDocker;
    };

    users.users.biruang.extraGroups = ["docker"];
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myDocker = pkgs.docker;
  };
}
