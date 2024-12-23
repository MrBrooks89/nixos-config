{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
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
      mrbrooks = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
        ./home.nix
        catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
    };
}
