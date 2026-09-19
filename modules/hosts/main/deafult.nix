{
  self,
  inputs,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    system = system;
    modules = [
      self.nixosModules.mainConfiguration
      {
        environment.systemPackages = [inputs.alejandra.defaultPackage.${system}];
      }
    ];
  };
}
