{ config, lib, ... }:


{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lsp.enable = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix.enable = true;
          python.enable = true;
          bash.enable = true;
          go.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;
        dashboard.dashboard-nvim.enable = true;
        filetree.neo-tree.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        treesitter.enable = true;
        utility.motion.leap.enable = true;
        autopairs.nvim-autopairs.enable = true;
        snippets.luasnip.enable = true;
        projects.project-nvim.enable = true;

        keymaps = [
          {
            key = "jj";
            mode = "i";
            action = "<Esc>";
            silent = true;
            noremap = true;
          }
        ];
        
        spellcheck = {
          enable = true;
        };
      
        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
         };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = true;
          illuminate.enable = true;
        };
      };
    };
  };
}

