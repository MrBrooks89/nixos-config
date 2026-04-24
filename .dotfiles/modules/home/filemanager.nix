{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myHomeModules.filemanager;
in {
  options.myHomeModules.filemanager = {
    enable = mkEnableOption "Enable Yazi File Manager & Configs";
  };

  config = mkIf cfg.enable {
    # Symlink the entire directory
    xdg.configFile."yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/yazi";
  };
}
