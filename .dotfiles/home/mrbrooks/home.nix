{ config, pkgs, inputs, lib, ... }:

{

imports =
    [ # Include the results of the hardware scan.
      ./starship.nix
      ./zsh.nix
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
  bottom
  btop
  cmatrix
  eza
  fastfetch
  fd
  ripgrep
  wget
  unzip
  tcpdump
  dig
  p7zip
  stress-ng

  # Development
  go
  python3
  nodejs
  stdenv.cc.cc.lib
  wlr-protocols
  python3.pkgs.xkbcommon
  python3.pkgs.pywayland

  # GUI Apps
  bottles
  cider
  discord
  floorp
  nautilus
  gnome-calculator
  kdePackages.konsole
  kdePackages.kate
  libreoffice-qt6-fresh
  obs-studio
  vlc
  vscode
  wireshark

  # Wayland/Hyprland
  grim
  hyprcursor
  hyprpaper
  jq
  kitty
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
  goverlay
  mangohud
  protontricks
  protonup-ng
  steamtinkerlaunch
  vkbasalt

  # System
  pavucontrol
  playerctl
  nwg-look
  libnotify

  # Security
  amass
  nmap

  # Themes
  adwaita-icon-theme
  papirus-icon-theme

  # ROCm
  ollama-rocm
  rocmPackages.rpp
  rocmPackages.rocm-smi

  # Misc
  teams-for-linux
];

  programs = {
    fzf.enable = true;
  };

  catppuccin = {
    enable = true;
    fzf = {
     enable = true;
     flavor = "mocha";
    }; 
    bat = {
     enable = true;
     flavor = "mocha";
    };
    kitty = {
     enable = true;
     flavor = "mocha";
    };
  };

  gtk = {
  enable = true;
  theme = {
    name = "Dracula";
    package = pkgs.dracula-theme;
  };
  iconTheme = {
    name = "Papirus-Dark";  # Match the theme's internal name
    package = pkgs.papirus-icon-theme;
  };
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
