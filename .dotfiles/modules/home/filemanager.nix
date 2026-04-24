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

    # Note: We keep yazi.enable = false if it conflicts, 
    # but usually yazi's HM module doesn't fight as much as Kitty's.
    # To be safe, we'll let your symlink do the work.
  };
}
