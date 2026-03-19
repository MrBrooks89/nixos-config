# Workspace Context: NixOS Dotfiles

You are assisting `mrbrooks` with their highly customized NixOS configuration. This workspace uses a modern, Flake-based approach with Home Manager for user-level configuration.

## System Architecture
- **OS**: NixOS (Unstable channel)
- **Kernel**: CachyOS (`linuxPackages-cachyos-latest`) with BBR congestion control enabled.
- **Bootloader**: `systemd-boot` (EFI).
- **Package Management**: Nix Flakes + Home Manager.
- **Hardware**: 
    - AMD CPU (microcode enabled)
    - AMD GPU (managed via `lact`)
    - Bluetooth (experimental features enabled for battery reporting)
    - Xbox Controller support (`xone` driver)
    - Printer: Canon MB2720 (`cnijfilter2` driver)

## Desktop Environment & UI
- **Window Manager**: 
    - **Niri**: Primary scroll-based tiling compositor.
    - **Hyprland**: Also enabled as an alternative.
- **Shell/UI Components**:
    - **Noctalia Shell**: Comprehensive DE-like shell (bar, dock, control center).
    - **Sherlock**: Feature-rich launcher/utility (Raycast/Alfred alternative).
    - **Waybar**: Used in conjunction with WMs.
    - **Mako**: Notification daemon.
    - **Kitty**: Primary terminal emulator.
- **Theming**: 
    - **GTK/Nvim/Noctalia**: Dracula (Night) theme.
    - **Icons**: Papirus-Dark.
    - **Cursors**: Rose-Pine.
    - **Fonts**: JetBrains Mono Nerd Font.

## Development Stack
- **Editor**: Neovim managed via **`nvf`** (notashelf/nvf).
    - Key bindings: `jj` for Esc, `y` for system clipboard (`"+y`).
    - Plugins: Copilot, blink-cmp, telescope, neogit, toggleterm.
- **Languages**: Go, Python, Nix (nil LSP), Rust, Node.js.
- **Shell**: Zsh + Starship.
    - Aliases: `cat` -> `bat`, `ls/ll/lt` -> `eza`, `nn/vim` -> `nvim`.
- **CLI Tools**: `yazi` (file manager), `fzf`, `lazygit`, `btop`, `fastfetch`.

## Configuration Workflow
- **Dotfile Location**: `/home/mrbrooks/.dotfiles`
- **Symlinking**: Config files in `/home/mrbrooks/.dotfiles/config/` (kitty, niri, waybar, yazi, mako) are symlinked to `~/.config/` via Home Manager `mkOutOfStoreSymlink`.
- **Updates**: Changes should be made in the `.nix` files or the `config/` directory, then applied via `nixos-rebuild switch --flake .` or `home-manager switch --flake .`.

## Interaction Guidelines
1. **Surgical Nix Changes**: When suggesting changes to `.nix` files, respect the existing module structure (`pkgs.nix`, `zsh.nix`, etc.).
2. **Symlink Awareness**: Remember that many configs are symlinked from the `.dotfiles/config` directory. If modifying a tool's config, check if it's managed via Nix or a symlinked file.
3. **Noctalia/Sherlock Knowledge**: Be aware of these specific inputs/modules as they handle significant portions of the UI.
4. **Performance & Gaming**: The system is tuned for performance (CachyOS, BBR, GameMode). Keep this in mind when suggesting system-level changes.
5. **Python Engineering**: The user is a senior Python engineer; provide high-quality, idiomatic code and guidance.
