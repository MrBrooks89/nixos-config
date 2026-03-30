{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myHomeModules.theme;
in {
  options.myHomeModules.theme = {
    enable = mkEnableOption "Enable GTK & System Theming (Dracula, Rose Pine, Papirus)";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;
      gtk4.theme = null;
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      iconTheme = lib.mkDefault {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "rose-pine-cursor";
        package = pkgs.rose-pine-cursor;
      };
    };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.rose-pine-cursor;
      name = "rose-pine-cursor";
      size = 24;
    };
  };
}
