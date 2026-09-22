{
  self,
  inputs,
  ...
}: {
  flake.homeModules.biruangModule = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
      inputs.niri.homeModules.niri
      self.homeModules.myVscode
      self.homeModules.myFirefox
      self.homeModules.myGit
      #self.homeModules.myZsh
      #self.homeModules.zsh
      self.homeModules.myNiri
      self.homeModules.myNoctalia
      #self.homeModules.myGhostty
      self.homeModules.ghostty
    ];

    home = {
      username = "biruang";
      homeDirectory = "/home/biruang";
      packages = with pkgs; [
        xwayland-satellite # xwayland support
        yandex-music
        telegram-desktop
      ];
      stateVersion = "26.05";
    };
  };
}
