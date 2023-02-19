{
  description = "Adrian's NixOS system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # Theming:
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, home-manager-unstable, nix-colors, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs-unstable.lib;
      home-manager.lib = home-manager-unstable.lib;

    in
    {
      homeManagerModules = import ./modules/home-manager;
      
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      nixosConfigurations = {
        # hostname is nixos
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };
      homeConfigurations = {
        hill = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/hill.nix ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
