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
      self.homeModules.vscode
      self.homeModules.myFirefox
      self.homeModules.git
      #self.homeModules.zsh
      self.homeModules.niri
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
