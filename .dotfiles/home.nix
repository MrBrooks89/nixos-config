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
    ./modules/home/sherlock.nix
    ./modules/home/nvf-config.nix
    ./modules/home/noctalia.nix
    ./modules/home/theme.nix
    ./modules/home/desktop.nix
    ./modules/home/filemanager.nix
    ./modules/home/packages.nix
  ];

  # Enable Home Modules
  myHomeModules.theme.enable = true;
  myHomeModules.desktop.enable = true;
  myHomeModules.filemanager.enable = true;

  home.username = "mrbrooks";
  home.homeDirectory = "/home/mrbrooks";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
    helix.enable = true;
  };
}
