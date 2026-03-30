{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myModules.dev;
in {
  options.myModules.dev = {
    enable = mkEnableOption "Enable Development Stack (Python, Go, Node, Docker)";
  };

  config = mkIf cfg.enable {
    # Enable Docker
    virtualisation.docker.enable = true;

    # Enable nix-ld for pre-compiled binaries (needed for some Neovim LSPs/plugins)
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld;
    };

    # Development Packages
    environment.systemPackages = with pkgs; [
      # Languages & Runtimes
      python3
      nodejs
      go
      lua
      luarocks-nix
      gcc
      stdenv.cc.cc.lib # Common C library for various tools

      # LSPs & Formatters
      nil
      nixpkgs-fmt
      lua51Packages.jsregexp

      # Tools
      ripgrep
      fd
      fzf
      lazygit
      docker-compose
      sshfs
      gemini-cli
      bootdev-cli
      
      # Python dependencies often needed for Wayland/UI libs
      python3.pkgs.xkbcommon
      python3.pkgs.pywayland
      
      # Misc Dev
      electron
      fping
      ueberzugpp
    ];
  };
}
