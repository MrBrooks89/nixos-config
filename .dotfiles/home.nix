{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./home-common.nix
    ./modules/home/sherlock.nix
    ./modules/home/noctalia.nix
    ./modules/home/theme.nix
    ./modules/home/desktop.nix
  ];

  # Enable Home Modules for Desktop
  myHomeModules.theme.enable = true;
  myHomeModules.desktop.enable = true;
  myHomeModules.filemanager.enable = true;
}
