{ config, modulesPath, ... }:

{
    imports = [
        (modulesPath + "/profiles/minimal.nix")
    ];
    programs.nvf = {
        enable = true;
        settings = {
            vim.viAlias = false;
            vim.vimAlias = true;
            vime.lsp = {
                enable = true;
            };
        };
    };
}