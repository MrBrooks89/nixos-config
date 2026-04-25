{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myModules.gaming;
in {
  options.myModules.gaming = {
    enable = mkEnableOption "Enable Gaming Stack (Steam, Gamescope, Drivers)";
  };

  config = mkIf cfg.enable {
    # System-level programs
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    programs.gamemode.enable = true;
    programs.gamemode.settings = {
      general = {
        renice = 10;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'GameMode has started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'GameMode has ended'";
      };
    };

    # Gaming Hardware / Drivers
    hardware.xpad-noone.enable = false;
    hardware.xpadneo.enable = false;
    hardware.xone.enable = true; # Xbox One controller driver

    # Session Variables for Gaming
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    # System-wide Gaming Packages
    environment.systemPackages = with pkgs; [
      # Launchers
      bottles
      heroic
      lutris

      # Tools/Compatibility
      gamescope
      mangohud
      mangojuice
      protontricks
      protonup-rs
      steamtinkerlaunch
      vkbasalt
      vulkan-tools
      winetricks
      wineWow64Packages.full

      # Performance/Info
      mesa-demos
    ];

    # Bluetooth tweak for controllers (disable_ertm)
    boot.extraModprobeConfig = mkAfter ''
      options bluetooth disable_ertm=Y
    '';
  };
}
