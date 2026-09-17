{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    #specialArgs = {
    #  inherit inputs;
    #};
    system = "x86_64-linux";

    modules = [
      self.nixosModules.mainConfiguration
    ];
  };
}
