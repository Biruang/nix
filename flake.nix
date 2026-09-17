{
  description = "Nixos config flake";

  nixConfig = {
    access-tokens = ["github.com="];
  };

  inputs = {
    #system
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #disc partitioning
    disco = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #stylix = {
    #  url = "github:nix-community/stylix/release -26.05";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #nixos formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    alejandra,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    homeStateVersion = "26.05";
    user = "biruang";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.${user} = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs homeStateVersion user;
      };
      modules = [
        ./nixos/configuration.nix
        inputs.home-manager.nixosModules.default
        #stylix.nixosModules.stylix
        #disko.nixosModules.disko
        #./disco.nix
        {
          environment.systemPackages = [alejandra.defaultPackage.${system}];
        }
      ];
    };
  };
}
