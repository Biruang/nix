{
  self,
  moduleWithSystem,
  ...
}: {
  flake.homeModules.git = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.homeModules; [];
  in {
    imports = modules;
    programs.git = {
      enable = true;
      package = self'.packages.myGit;
      settings = {
        user = {
          name = "Biruang";
          email = "saidovte@gmail.com";
        };
      };
    };
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myGit = pkgs.git;
  };
}
