local home = os.getenv("HOME")
--vim.cmd("let g:netrw_liststyle = 3")

--vim.g.netrw_banner = 0
--vim.g.netrw_liststyle = 3
--vim.keymap.set("n", "<Space>", "", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

print("VS Code NeoVim Initialized")
--vim.keymap.set('n', '<leader>t', ':echo "Test Leader Key"<CR>', { noremap = true, silent = true })
--vim.keymap.set('n', '<Space>y', ':echo "Direct Space Key"<CR>', { noremap = true, silent = true })

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--vim.schedule(function()
vim.opt.clipboard:append("unnamedplus")
  --end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = home .. '/.config/undodir'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive


-- Keep signcolumn on by default so that text doesn't shift
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom


-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- tabs & indentation
vim.opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.wrap = false

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark


-- backspace. -- allow backspace on indent, end of line or insert mode start position
vim.opt.backspace = "indent,eol,start" 

-- turn off swapfile
vim.opt.swapfile = false

--vim.opt.foldopen = "" 