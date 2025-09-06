{
        description = "My flake";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
                rose-pine-hyprcursor = {
                        url = "github:ndom91/rose-pine-hyprcursor";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                sherlock = {
                        url = "github:Skxxtz/sherlock";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                nvf = {
                        url = "github:notashelf/nvf";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = { nixpkgs, home-manager, nvf, ... } @ inputs:
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
                                        ];
                                };
                        };

                        homeConfigurations = {
                                # Home Manager configuration for mrbrooks
                                mrbrooks = home-manager.lib.homeManagerConfiguration {
                                        inherit pkgs;
                                        extraSpecialArgs = { inherit inputs; };
                                        modules = [
                                                ./home.nix
                                                nvf.homeManagerModules.default
                                        ];
                                };
                        };
                };
}
