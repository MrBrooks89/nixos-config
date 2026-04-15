{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI Utilities
    ani-cli
    appimage-run
    bat
    btop
    cmatrix
    viu
    chafa
    ueberzugpp
    eza
    fastfetch
    ipcalc
    wget
    unzip
    tcpdump
    dig
    p7zip
    stress-ng
    vim

    # GUI Apps
    discord
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

    # Security
    amass
    nmap

    # Teams
    teams-for-linux
  ];
}
