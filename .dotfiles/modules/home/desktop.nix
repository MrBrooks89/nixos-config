{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myHomeModules.desktop;
in {
  options.myHomeModules.desktop = {
    enable = mkEnableOption "Enable Home Desktop Environment Configs (Niri, Waybar, Kitty, etc.)";
  };

  config = mkIf cfg.enable {
    # Symlink the entire directories instead of individual files
    xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "/home/mrbrooks/.dotfiles/config/kitty";
    xdg.configFile."niri".source = config.lib.file.mkOutOfStoreSymlink "/home/mrbrooks/.dotfiles/config/niri";
    xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/mrbrooks/.dotfiles/config/waybar";
    xdg.configFile."mako".source = config.lib.file.mkOutOfStoreSymlink "/home/mrbrooks/.dotfiles/config/mako";

    # We do NOT use programs.kitty.enable = true here because 
    # we are managing the config manually via symlink.
  };
}
