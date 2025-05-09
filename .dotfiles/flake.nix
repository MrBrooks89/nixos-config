{
  description = "My flake for multiple users";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... } @ inputs:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };
    };

    homeConfigurations = {
      # Home Manager configuration for mrbrooks
      mrbrooks = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/mrbrooks/home.nix
          catppuccin.homeModules.catppuccin
        ];
      };
     
     # Home Manager configuration for mrsbrooks
     mrsbrooks = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [
         ./home/mrsbrooks/home.nix
         catppuccin.homeModules.catppuccin
       ];
      };

    };
  };
}
