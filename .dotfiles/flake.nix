{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
    yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = {
  nixpkgs,
  home-manager,
  nvf,
  nix-cachyos-kernel,
  noctalia-qs,
  noctalia,
  ...
} @ inputs: let

    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          ringcentral = final.callPackage ./pkgs/ringcentral {};
          exiled-exchange = final.callPackage ./pkgs/exiled-exchange {};
        })
      ];
    };
  in {
    nixosConfigurations = {
      gamingdesktop = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/gamingdesktop/default.nix
        ];
      };
      nixos-server = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-server/default.nix
        ];
      };
    };

    homeConfigurations = {
      # Home Manager configuration for mrbrooks on Gaming Desktop
      "mrbrooks@gamingdesktop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home.nix
          nvf.homeManagerModules.default
        ];
      };

      # Home Manager configuration for mrbrooks on NixOS Server
      "mrbrooks@nixos-server" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home-server.nix
          nvf.homeManagerModules.default
        ];
      };
    };
  };
}
