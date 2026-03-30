{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myModules.desktop;
in {
  options.myModules.desktop = {
    enable = mkEnableOption "Enable Desktop Environment (Niri, Hyprland, GDM)";
  };

  config = mkIf cfg.enable {
    # Enable Niri
    programs.niri.enable = true;

    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Display Manager
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    # Wayland/Electron Fixes
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Fonts
    fonts.packages = with pkgs; [
      font-awesome
      powerline-fonts
      powerline-symbols
      nerd-fonts.jetbrains-mono
    ];

    # Desktop Packages
    environment.systemPackages = with pkgs; [
      # Core Wayland Tools
      grim
      slurp
      wl-clipboard
      waybar
      mako
      swww
      swaybg
      
      # Lockscreens / Idle
      hyprlock
      hypridle
      hyprpaper
      swaylock-effects

      # Screenshots / Image handling
      satty
      swappy
      jq # often used in screenshot scripts

      # Utility
      wofi
      wmctrl
      xdotool
      xwayland-satellite
      libnotify
      playerctl
      pavucontrol
      nwg-look

      # Protocols
      wlr-protocols
    ];
  };
}
