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
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, home-manager-unstable, ... }: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs-unstable.lib;
    hm-lib = home-manager-unstable.lib;
    
  in {
    nixosConfigurations = {
      # hostname is nixos
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix    
        ];
      };
    };
    homeConfigurations.hill = hm-lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home/hill.nix
      ];
    };
  };
}
