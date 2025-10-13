{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    # Essential plugins
    plugins = with pkgs.vimPlugins; [
      # Plugin management
      packer-nvim
      
      # Appearance
      nvim-web-devicons
      lualine-nvim
      nvim-base16
      telescope-nvim
      
      # Syntax highlighting & parsing
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-python
        p.tree-sitter-go
        p.tree-sitter-lua
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-json
        p.tree-sitter-yaml
        p.tree-sitter-markdown
        p.tree-sitter-comment
      ]))
      
      # LSP & completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      lspkind-nvim
      
      # Language specific
      nvim-lsp-ts-utils  # TypeScript utilities
      vim-nix  # Nix syntax highlighting
      
      # Utilities
      plenary-nvim
      telescope-fzf-native-nvim
      comment-nvim
      vim-surround
      vim-repeat
    ];
    
  };

  # Neovim configuration
  xdg.configFile."nvim/init.lua".text = ''
    -- Set leader key
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Keymaps for jj to escape in insert mode
    vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
    vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

    -- Basic settings
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
    vim.opt.smartindent = true
    vim.opt.wrap = false
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true
    vim.opt.hlsearch = false
    vim.opt.incsearch = true
    vim.opt.termguicolors = true
    vim.opt.scrolloff = 8
    vim.opt.signcolumn = "yes"
    vim.opt.updatetime = 50

    -- Packer plugin management
    require('packer').startup(function(use)
      use 'wbthomason/packer.nvim'
      
      -- Appearance
      use 'nvim-tree/nvim-web-devicons'
      use 'nvim-lualine/lualine.nvim'
      use 'RRethy/nvim-base16'
      use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
      }
      
      -- Treesitter
      use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
      }
      
      -- LSP
      use 'neovim/nvim-lspconfig'
      use 'hrsh7th/nvim-cmp'
      use 'hrsh7th/cmp-nvim-lsp'
      use 'hrsh7th/cmp-buffer'
      use 'hrsh7th/cmp-path'
      use 'hrsh7th/cmp-cmdline'
      use 'onsails/lspkind.nvim'
      
      -- Utilities
      use 'nvim-telescope/telescope-fzf-native.nvim'
      use 'terrortylor/nvim-comment'
      use 'tpope/vim-surround'
      use 'tpope/vim-repeat'
    end)

    -- Lualine configuration
    require('lualine').setup({
      options = {
        theme = 'base16'
      }
    })

    -- Treesitter configuration
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "nix", "python", "go", "lua", "vim", "bash", 
        "json", "yaml", "markdown", "comment"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })

    -- LSP setup
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Nix LSP
    require('lspconfig').nil_ls.setup({
      capabilities = capabilities,
    })

    -- Go LSP
    require('lspconfig').gopls.setup({
      capabilities = capabilities,
    })

    -- Python LSP
    require('lspconfig').pyright.setup({
      capabilities = capabilities,
    })

    -- Completion setup
    local cmp = require'cmp'
    cmp.setup({
      snippet = {
        expand = function(args)
          -- You can add snippet engine here if needed
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      })
    })

    -- Telescope setup
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })
    require('telescope').load_extension('fzf')

    -- Keymaps
    local keymap = vim.keymap.set

    -- Telescope keymaps
    keymap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find files' })
    keymap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Live grep' })
    keymap('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Find buffers' })
    keymap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help tags' })

    -- LSP keymaps
    keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
    keymap('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Go to references' })
    keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
    keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
    keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
    keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })

    -- Comment setup
    require('nvim_comment').setup()

    -- Set colorscheme
    vim.cmd('colorscheme base16-default-dark')
  '';
}
