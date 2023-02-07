{
  description = "Adrian's NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager"; #/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { nixpkgs, home-manager, ... }: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
    
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
  };
}
