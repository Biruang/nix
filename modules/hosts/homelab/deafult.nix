{
  self,
  inputs,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.homelab = inputs.nixpkgs.lib.nixosSystem {
    system = system;
    modules = [
      self.nixosModules.homelabConfig
      #self.nixosModules.myHomeManager
      #{
      #  environment.systemPackages = [inputs.alejandra.defaultPackage.${system}];
      #}
    ];
  };
}
