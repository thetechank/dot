-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Helper function since TSUpdate doesn't work
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
updateTS = function() 
    require('nvim-treesitter.install').update(
        { with_sync = true }
    )
end

installMD = function() vim.fn["mkdp#util#install"]() end

require('packer').init({ max_jobs = 8 })
use = require('packer').use

use 'wbthomason/packer.nvim'
use 'eandrju/cellular-automaton.nvim'
use 'numToStr/Comment.nvim'

-- Looks
use 'nvim-lualine/lualine.nvim'
use 'rmehri01/onenord.nvim'
use 'shaunsingh/nord.nvim'
use 'kyazdani42/nvim-web-devicons'

-- File/buffer/window management
use 'nvim-telescope/telescope.nvim'
use 'nvim-telescope/telescope-ui-select.nvim'
use 'debugloop/telescope-undo.nvim'
use 'sindrets/winshift.nvim'
use 'stevearc/oil.nvim'

-- Autocomplete (cmp)
use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/vim-vsnip'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'

-- LSP stuff
use 'rhysd/git-messenger.vim'
use 'rmagatti/goto-preview'
use 'neovim/nvim-lspconfig'
use 'nvim-lua/plenary.nvim'
use {'nvim-treesitter/nvim-treesitter', run=updateTS }
use 'nvim-treesitter/nvim-treesitter-context'
use {'iamcco/markdown-preview.nvim', run=installMD }

