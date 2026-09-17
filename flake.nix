{
  description = "Nixos flake system configuration";

  nixConfig = {
    access-tokens = [""];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    #For dendritic pattern
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    #Wrapper for nix modules
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    #disco = {
    #  url = "github:nix-community/disko/latest";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #home-manager = {
    #  url = "github:nix-community/home-manager/release-26.05";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #stylix = {
    #  url = "github:nix-community/stylix/release-26.05";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #nixos formatter
    #alejandra = {
    #  url = "github:kamadorueda/alejandra/4.0.0";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);

  #outputs = {
  #  self,
  #  nixpkgs,
  #  disko,
  #  alejandra,
  #  home-manager,
  #  stylix,
  #  ...
  #} @ inputs: let
  #  system = "x86_64-linux";
  #  homeStateVersion = "26.05";
  #  user = "biruang";
  #in {
  #nixosConfigurations.${user} = nixpkgs.lib.nixosSystem {
  #  system = system;
  #  specialArgs = {
  #    inherit inputs homeStateVersion user;
  #  };
  #  modules = [
  #    stylix.nixosModules.stylix
  #    #disko.nixosModules.disko
  #    ./nixos/configuration.nix
  #    #./disco.nix
  #    {
  #      environment.systemPackages = [alejandra.defaultPackage.${system}];
  #    }
  #  ];
  #};

  #homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
  #  pkgs = nixpkgs.legacyPackages.${system};
  #  extraSpecialArgs = {
  #    inherit inputs homeStateVersion user;
  #  };
  #  modules = [
  #    ./home-manager/home.nix
  #  ];
  #};
  #};
}
