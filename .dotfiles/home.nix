{ config, pkgs, inputs, lib, ... }:

{

        imports =
                [ 
                        ./starship.nix
                        ./zsh.nix
                        ./sherlock.nix
                        #./nvf-config.nix
                ];


        # Home Manager needs a bit of information about you and the paths it should
        # manage.
        home.username = "mrbrooks";
        home.homeDirectory = "/home/mrbrooks";


        home.stateVersion = "24.11"; # Please read the comment before changing.


        nixpkgs.config.allowUnfree = true;

        home.packages = import ./pkgs.nix { inherit pkgs; };

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

        programs.yazi = {
          enable = true;
        };
        programs.helix = {
          enable = true;
        };
}
