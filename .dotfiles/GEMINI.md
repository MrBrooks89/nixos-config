# Workspace Context: NixOS Dotfiles

You are assisting `mrbrooks` with their highly customized NixOS configuration. This workspace uses a modern, Flake-based approach with Home Manager for multi-host management.

## System Architecture
- **OS**: NixOS (Unstable channel)
- **Hosts**:
    - **gamingdesktop**: Primary workstation.
        - **Kernel**: CachyOS (`linuxPackages-cachyos-latest`) with BBR.
        - **Hardware**: AMD CPU/GPU (managed via `lact`), Bluetooth, Xbox Controller support.
        - **Bootloader**: `systemd-boot` (EFI).
    - **nixos-server**: Proxmox/HomeLab guest.
        - **Role**: Service hosting (Cloudflared tunnels, Cron jobs, SMB/CIFS mounts).
        - **Bootloader**: GRUB.
- **Package Management**: Nix Flakes + Home Manager.

## Desktop Environment & UI (gamingdesktop)
- **Window Manager**: **Niri** (Primary), Hyprland (Alternative).
- **Shell/UI**: **Noctalia Shell**, **Sherlock** launcher, Waybar, Mako.
- **Theming**: Dracula (Night) for GTK/Nvim/Noctalia, Papirus-Dark icons.
- **Fonts**: JetBrains Mono Nerd Font.

## Development Stack
- **Editor**: Neovim managed via **`nvf`** (key bindings: `jj` for Esc, `y` for system clipboard).
- **Languages**: Go, Python, Nix (nil LSP), Rust, Node.js.
- **Shell**: Zsh + Starship. Aliases: `cat` -> `bat`, `ls/ll` -> `eza`, `nn/vim` -> `nvim`.
- **CLI Tools**: `yazi` (file manager), `fzf`, `lazygit`, `btop`.

## Configuration Workflow
- **Dotfile Location**: `/home/mrbrooks/.dotfiles` (or `~/nixos-config` on server).
- **Home Manager Structure**:
    - **`home-common.nix`**: Shared base (Zsh, Nvim, Starship, basic tools).
    - **`home.nix`**: Desktop/Gaming specific config (imports common base).
    - **`home-server.nix`**: Lightweight server config (imports common base, disables GUI modules).
- **Applying Changes**:
    - **System**: `sudo nixos-rebuild switch --flake .#<hostname>`
    - **User**: `home-manager switch --flake .#mrbrooks@<hostname>`

## Interaction Guidelines
1. **Surgical Nix Changes**: Respect the module structure (`hosts/`, `modules/`, etc.).
2. **Symlink Awareness**: UI configs in `config/` are symlinked via `mkOutOfStoreSymlink`.
3. **Multi-Host Safety**: When adding packages/configs, decide if they belong in `home-common.nix` (shared) or machine-specific files.
4. **Git Visibility**: Nix Flakes require files to be tracked in Git. Always remind the user to `git add` new files.
5. **Python Engineering**: The user is a senior Python engineer; provide high-quality, idiomatic code and guidance.
