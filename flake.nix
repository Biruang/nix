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
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #wayland compositor
    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #wayland shell
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #noctalia greeter
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
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
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    stateVersion = "26.05";
    user = "biruang";
    #pkgs = nixpkgs.legacyPackages.${system};

    hosts = [
      {hostname = "main";}
    ];
    #system config constructor for hosts
    makeSystem = {hostname}:
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs stateVersion hostname user;
        };

        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs stateVersion user;};
            home-manager.users.${user} = ./hosts/${hostname}/home.nix;
            home-manager.backupFileExtension = "backup";
          }
          #stylix.nixosModules.stylix
          disko.nixosModules.disko
          ./hosts/${hostname}/disko.nix
          {
            environment.systemPackages = [inputs.alejandra.defaultPackage.${system}];
          }
        ];
      };
  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs
      // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname;
        };
      }) {}
    hosts;
  };
}
