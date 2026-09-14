{
  description = "Nixos flake system configuration";

  nixConfig = {
    access-tokens = [ "github.com=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" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let 
    system = "x86_64-linux";
    homeStateVersion = "26.05";
    user = "biruang";
  in {
    nixosConfigurations.${user} = nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = { 
        inherit inputs homeStateVersion user;
      };
      modules = [
        ./nixos/configuration.nix
      ];
    };

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user;
      };
      modules = [ 
        ./home-manager/home.nix
      ];
    };
  };
}
