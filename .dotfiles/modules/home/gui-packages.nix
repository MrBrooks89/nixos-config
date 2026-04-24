{pkgs, lib, config, ...}: {
  config = lib.mkIf (config.myHomeModules.desktop.enable or false) {
    home.packages = with pkgs; [
      # GUI Apps
      discord
      exiled-exchange
      firefox
      freerdp
      nautilus
      kdePackages.konsole
      libreoffice-qt6-fresh
      obs-studio
      vlc
      vscodium
      wireshark
      ringcentral
      joplin-desktop

      # Teams
      teams-for-linux
    ];
  };
}
