{
  self,
  moduleWithSystem,
  ...
}: {
  flake.homeModules.obsidian = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = with self.homeModules; [];
  in {
    imports = modules;
    programs.obsidian = {
      enable = true;

      vaults.notes.target = "obsidian";

      defaultSettings.app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
      };
    };
  });
}
