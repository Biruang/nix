{
  self,
  moduleWithSystem,
  ...
}: {
  flake.homeModules.ghostty = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = [self.homeModules.zsh];
  in {
    imports = modules;
    programs.ghostty = {
      enable = true;
      package =
        self'.packages.myGhostty;
      enableZshIntegration = true;
    };
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myGhostty = pkgs.ghostty;
  };
}
