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
   appimage-run  
   amass
   bat
   bottles
   btop
   cmatrix
   cider
   dig
   discord
   dunst
   eza
   fastfetch
   floorp
   gamescope
   go
   goverlay
   grim
   hyprcursor
   kdePackages.kate
   kdePackages.konsole
   kitty
   libnotify
   libreoffice-qt6-fresh
   mangohud
   nautilus
   nwg-look
   obs-studio
   ollama-rocm
   pavucontrol
   playerctl
   protonup-ng
   python311
   python311Packages.pip
   python311Packages.virtualenv
   p7zip
   rocmPackages.rpp
   rocmPackages.rocm-smi
   rofi-wayland
   slurp
   starship
   stdenv.cc.cc.lib
   steamtinkerlaunch
   swaybg
   swaylock-effects
   swappy
   swww
   tcpdump
   teams-for-linux
   unzip
   vim
   vkbasalt
   vlc
   vscode
   waybar
   wget
   wl-clipboard
   wireshark
   wofi
   xdotool
  ];

  programs = {
    fzf.enable = true;
  };

  catppuccin = {
    enable = true;
    fzf = {
     enable = true;
     flavor = "latte";
    }; 
    bat = {
     enable = true;
     flavor = "latte";
    };
    kitty = {
     enable = true;
     flavor = "latte";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
