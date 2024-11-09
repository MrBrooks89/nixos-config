{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mrbrooks";
  home.homeDirectory = "/home/mrbrooks";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    hello
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mrbrooks/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.starship = {
  enable = true;

  settings = {
    # General Starship settings
    add_newline = false;
    command_timeout = 1000;
    format = ''
    $character$os$hostname$directory$git_branch$git_status$python$aws$golang$java$nodejs
    $fill
    [└─>](bold green)'';

    # Character module
    character = {
      success_symbol = "🚀 ";
      error_symbol = "🔥 ";
    };

    # Fill module
    fill = {
      symbol = " ";
    };

    # Time module
    time = {
      disabled = false;
      time_format = "%r";
      style = "bg:#1d2230";
      format = "[[ 󱑍 $time ](bg:#1C3A5E fg:#8DFBD2)]($style)";
    };

    # Command duration module
    cmd_duration = {
      format = "last command: [$duration](bold yellow)";
    };

    # OS module
    os = {
      format = "[$symbol](bold white) ";
      disabled = false;
      symbols = { Macos = "󰀵"; };
    };

    # Hostname module
    hostname = {
      ssh_only = false;
      format = "on [$hostname](bold yellow) ";
      disabled = false;
      ssh_symbol = " ";
    };

    # Directory module
    directory = {
      truncation_length = 3;
      fish_style_pwd_dir_length = 2;
      home_symbol = "󰋜 ~";
      read_only_style = "197";
      read_only = "  ";
      format = "at [$path]($style)[$read_only]($read_only_style)";
    };

    # Git branch module
    git_branch = {
      symbol = " ";
      format = "via [$symbol$branch]($style)";
      truncation_symbol = "…/";
      style = "bold red";
    };

    # Git status module
    git_status = {
      format ="[$all_status$ahead_behind]($style) ";
      style = "bold green";
      conflicted = "🏳";
      up_to_date = "";
      untracked = " ";
      ahead = "⇡";
      diverged = "⇕⇡⇣";
      behind = "⇣";
      stashed = " ";
      modified = " ";
      staged = "[++]";
      renamed = "襁 ";
      deleted = " ";
    };

    # AWS module
    aws = {
      symbol = "  ";
    };

    # Python module
    python = {
      symbol = " ";
      pyenv_version_name = true;
    };

    # Go module
    golang = {
      symbol = " ";
    };

    # Java module
    java = {
      symbol = " ";
    };

    # NodeJS module
    nodejs = {
      symbol = " ";
    };
  };
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
