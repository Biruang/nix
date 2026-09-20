{
  self,
  inputs,
  ...
}: {
  #flake.homeConfigurations.biruang = inputs.home-manager.lib.homeManagerConfiguration {
  #  pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
  #  modules = [
  #    self.homeModules.biruangModule
  #    {
  #      home.username = "biruang";
  #      home.homeDirectory = "/home/biruang";
  #    }
  #  ];
  #};

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
      self.homeModules.myZsh
      self.homeModules.myNiri
      self.homeModules.myNoctalia
    ];

    home = {
      username = "biruang";
      homeDirectory = "/home/biruang";
      packages = with pkgs; [
        xwayland-satellite # xwayland support
        yandex-music
      ];
      stateVersion = "26.05";
    };
  };
}
