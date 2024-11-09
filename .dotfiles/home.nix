{ config, pkgs, inputs, ... }:

{

imports =
    [ # Include the results of the hardware scan.
      ./starship.nix
      ./zsh.nix
      ./bat.nix
    ];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mrbrooks";
  home.homeDirectory = "/home/mrbrooks";


  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
   bottles
   btop
   cmatrix
   cider
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
   kitty
   libnotify
   mangohud
   nautilus
   nwg-look
   pavucontrol
   playerctl
   protonup-ng
   python3
   python311Packages.pip
   rocmPackages.rpp
   rocmPackages.rocm-smi
   rofi-wayland
   slurp
   starship
   swaybg
   swaylock-effects
   swappy
   swww
   teams-for-linux
   unzip
   vim
   vscode
   waybar
   wget
   wl-clipboard
   wofi
   xdotool
  ];

  programs = {
    fzf.enable = true;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
