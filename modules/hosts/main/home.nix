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
      self.homeModules.git
    ];

    home = {
      username = "biruang";
      homeDirectory = "/home/biruang";
      packages = with pkgs; [
        yandex-music
        telegram-desktop
      ];
      stateVersion = "26.05";
    };
  };
}
