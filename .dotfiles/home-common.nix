{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./modules/home/starship.nix
    ./modules/home/zsh.nix
    ./modules/home/nvf-config.nix
    ./modules/home/filemanager.nix
    ./modules/home/packages.nix
  ];

  home.username = "mrbrooks";
  home.homeDirectory = "/home/mrbrooks";
  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
    helix.enable = true;
  };
}
