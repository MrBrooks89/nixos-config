{ config, pkgs, inputs, lib, ... }:

{

imports =
    [ # Include the results of the hardware scan.
      ./starship.nix
      ./zsh.nix
      ./sherlock.nix
    ];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mrbrooks";
  home.homeDirectory = "/home/mrbrooks";


  home.stateVersion = "24.11"; # Please read the comment before changing.
    

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
  # CLI Utilities
  appimage-run
  bat
  btop
  cmatrix
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
  electron
  go
  python3
  nodejs
  stdenv.cc.cc.lib
  wlr-protocols
  python3.pkgs.xkbcommon
  python3.pkgs.pywayland

  # GUI Apps
  bottles
  #cider
  discord
  floorp
  firefox
  nautilus
  kdePackages.konsole
  libreoffice-qt6-fresh
  obs-studio
  vlc
  vscode
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
];

  programs = {
    fzf.enable = true;
    thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
      };
    };
  };
   
  gtk = {
  enable = true;
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
