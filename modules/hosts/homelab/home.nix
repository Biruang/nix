{
  self,
  inputs,
  ...
}: {
  flake.homeModules.homelabHome = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.homeModules.git
      self.homeModules.zsh
    ];

    home = {
      username = "biruang";
      homeDirectory = "/home/biruang";
      packages = with pkgs; [
        #xwayland-satellite # xwayland support
        #yandex-music
        #telegram-desktop
      ];
      stateVersion = "26.05";
    };
  };
}
