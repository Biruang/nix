{
  self,
  inputs,
  ...
}: {
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
