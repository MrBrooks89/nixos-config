{ config, pkgs, ... }:

{

  imports =
    [
      ./starship.nix
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mrbrooks";
  home.homeDirectory = "/home/mrbrooks";


  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    hello
  ];

  nixpkgs.config.allowUnfree = true;


  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };




  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;
    shellAliases = {
      ll = "exa -al --icons";
      ls = "exa -a --icons";
      lt = "exa -a --tree --level=1 --icons";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
