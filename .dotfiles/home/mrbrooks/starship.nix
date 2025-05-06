{ config, pkgs, ... }:

{

catppuccin = {
  enable = true;
  starship = {
   enable = true;
   flavor = "mocha";
  };
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
      staged = "++";
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

}
