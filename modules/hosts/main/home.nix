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
    #programs.bash.enable = true;
    #programs.bash.shellAliases.ll = "ls -l";

    imports = [
      inputs.noctalia.homeModules.default
      inputs.niri.homeModules.niri
      self.homeModules.myVscode
      self.homeModules.myFirefox
      self.homeModules.myGit
      self.homeModules.myZsh
      self.homeModules.myNiri
      self.homeModules.myNoctalia
      #  ../../home/firefox.nix
      #  ../../home/vscode.nix
    ];

    home = {
      username = "biruang";
      homeDirectory = "/home/biruang";
      packages = [
        pkgs.yandex-music
      ];
      stateVersion = "26.05";
    };
  };
}
