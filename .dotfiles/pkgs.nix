{ pkgs }:

with pkgs; [
        # CLI Utilities
        appimage-run
        bat
        btop
        cmatrix
        viu
        chafa
        ueberzugpp
        eza
        fastfetch
        fd
        ipcalc
        wget
        unzip
        tcpdump
        dig
        p7zip
        stress-ng
        vim

        # Development
        bootdev-cli
        docker-compose
        electron
        go
        gcc
        gnomeExtensions.arcmenu
        gnomeExtensions.dash-to-dock
        gnomeExtensions.weather-oclock
        gnomeExtensions.blur-my-shell
        gnomeExtensions.just-perfection
        gnomeExtensions.extension-list
        gnomeExtensions.open-bar
        gnomeExtensions.appindicator
        python3
        nodejs
        stdenv.cc.cc.lib
        ripgrep
        wlr-protocols
        python3.pkgs.xkbcommon
        python3.pkgs.pywayland
        lua51Packages.jsregexp

        # GUI Apps
        bottles
        discord
        floorp
        firefox
        freerdp
        nautilus
        kdePackages.konsole
        libreoffice-qt6-fresh
        obs-studio
        vlc
        vscodium
        wireshark


        # Wayland/Hyprland
        grim
        hyprlock
        hypridle
        hyprcursor
        hyprpaper
        jq
        rofi-wayland
        slurp
        swaybg
        swaylock-effects
        swappy
        swww
        waybar
        wl-clipboard
        wofi
        wmctrl
        xdotool

        # Gaming
        gamescope
        glxinfo
        lutris
        mangohud
        mangojuice
        protontricks
        protonup-ng
        steamtinkerlaunch
        winetricks
        wineWowPackages.full
        vkbasalt
        vulkan-tools

        # System
        pavucontrol
        playerctl
        nwg-look
        libnotify

        # Security
        amass
        nmap

        # ROCm
        ollama-rocm
        rocmPackages.rpp
        rocmPackages.rocm-smi

        # Misc
        teams-for-linux
]

