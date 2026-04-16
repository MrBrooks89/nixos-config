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

    # Security
    amass
    nmap
  ];
}
