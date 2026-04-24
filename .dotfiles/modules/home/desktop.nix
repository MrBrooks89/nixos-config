{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myHomeModules.desktop;
in {
  imports = [
    ./gui-packages.nix
  ];

  options.myHomeModules.desktop = {
    enable = mkEnableOption "Enable Home Desktop Environment Configs (Niri, Waybar, Kitty, etc.)";
  };

  config = mkIf cfg.enable {
    # Symlink the entire directories instead of individual files
    xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/kitty";
    xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/niri";
    xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/waybar";
    xdg.configFile."mako".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/mako";
  };
}
