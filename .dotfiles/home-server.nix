{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./home-common.nix
    ./modules/home/desktop.nix
    ./modules/home/theme.nix
  ];

  # Explicitly disable GUI modules for the server
  myHomeModules.theme.enable = false;
  myHomeModules.desktop.enable = false;
  myHomeModules.filemanager.enable = true; # Keep your terminal-based file manager (Yazi) if you want!
}
