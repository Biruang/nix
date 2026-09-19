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

  flake.homeModules.biruangModule = {pkgs, ...}: {
    #programs.bash.enable = true;
    #programs.bash.shellAliases.ll = "ls -l";

    imports = [
      self.homeModules.myVscode
      #  ../../home/firefox.nix
      #  ../../home/vscode.nix
    ];

    home = {
      username = "biruang";
      homeDirectory = "/home/biruang";
      packages = [];
      stateVersion = "26.05";
    };
  };
}
