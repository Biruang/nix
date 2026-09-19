{
  self,
  inputs,
  ...
}: {
  flake.nixosConfiguration.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.mainConfiguration
    ];
  };
}
