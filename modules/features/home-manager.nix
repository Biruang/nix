{
  self,
  inputs,
  ...
}: {
  flake.homeConfigurations.biruang = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.myHomeManager
      {
        home.username = "biruang";
        home.homeDirectory = "/home/biruang";
      }
    ];
  };

  flake.nixosModules.myHomeManager = {pkgs, ...}: {
    imports = [
      # official home-manager nixos module
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
