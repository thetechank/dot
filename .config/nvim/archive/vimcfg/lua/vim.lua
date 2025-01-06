local vset = vim.opt
local home = os.getenv("HOME")

vim.g['mapleader'] = ' '
vim.g['localleader'] = '\\'

vset.relativenumber = false
vset.syntax = on

vim.cmd("colorscheme onenord")
vim.api.nvim_set_hl(0, 'vertsplit', { fg = "LightSteelBlue4" })

vset.laststatus = 2 --Always keep statusbar
vset.belloff='all'

-- Better tab completion for filenames
vset.wildmode=longest,list
vset.wildmenu = true

vset.hls = false
vset.ignorecase = true
vset.smartcase = true

-- Relative linenumbers except current line 
vset.number = true
vset.relativenumber = true

-- More intuitve split locations
vset.splitbelow = true
vset.splitright = true

-- Hidden buffers for easy switching
vset.hidden = true

-- Set tab=4 spaces
vset.expandtab = true
vset.tabstop = 4
vset.softtabstop = 4
vset.shiftwidth = 4

-- Keep undo history
vset.undofile = true
vset.undodir = home .. '/.config/undodir'

-- Prevent swp files from accidentally getting gitted
vset.directory = home .. '/.config/swapfiles/'

vset.spelllang = 'en_gb'
vset.joinspaces = false

vset.foldmethod = 'expr'
vset.foldexpr = 'nvim_treesitter#foldexpr()'

vset.foldenable = false
vim.opt.colorcolumn = "81"
vim.cmd("hi vertsplit guifg=#616e88 guibg=bg")

local setup_glft = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.cmd("set ft=json")
end

vim.api.nvim_create_augroup("gltf", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufNew"}, {
    group = "gltf",
    pattern = { "*.gltf" },
    callback = setup_glft
})

-- SSH config is split up, set ft on everything within `config.d/`
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = { "/home/rintse/.ssh/config.d/*" },
    callback = function() vim.cmd("set ft=sshconfig") end
})

require('Comment').setup()

vim.keymap.set('n', '<Space>', '<Nop>', {desc='Unbind leader'})

vim.keymap.set('n', 'Z', '<Nop>', {desc='Avoid accidental close'})
vim.keymap.set('n', 'ZZ', '<Nop>', {desc='Avoid accidental close'})

-- Place cursor in between these characters when typed
vim.keymap.set('i', '\"\"', '\"\"<Left>')
vim.keymap.set('i', '\'\'', '\'\'<Left>')
vim.keymap.set('i', '()', '()<Left>')
vim.keymap.set('i', '{}', '{}<Left>')
vim.keymap.set('i', '[]', '[]<Left>')

-- I hate f1
vim.keymap.set('n', '<F1>', '<Nop>')
vim.keymap.set('i', '<F1>', '<Nop>')

-- Line objects
vim.keymap.set('x', 'il', 'g_o^', {desc='Inner line object'})
vim.keymap.set('o', 'il', ':normal vil<CR>')
vim.keymap.set('x', 'al', '$o^', {desc='Outer line object'})
vim.keymap.set('o', 'al', ':normal val<CR>')

-- (un)indent [selection]
vim.keymap.set('n', '<Tab>', '>')
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('n', '<S-Tab>', '<')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Delete into the black hole register
vim.keymap.set('n', '<Del>' , '\"_x')

-- search for the current word/selection, while keeping cursor
vim.keymap.set({'n','v'}, '<Leader>d', '*N')
vim.keymap.set('n', '<C-P>', '<C-I>')
vim.keymap.set('n', '<Leader>w', ':w<CR>')

-- Window management
vim.keymap.set('n', '<Leader>mm', '<Cmd>WinShift<CR>',          {silent=true})
vim.keymap.set('n', '<Leader>mx',  '<Cmd>WinShift swap<CR>',    {silent=true})
vim.keymap.set('n', '<Leader>mh', '<Cmd>WinShift left<CR>',     {silent=true})
vim.keymap.set('n', '<Leader>mj', '<Cmd>WinShift down<CR>',     {silent=true})
vim.keymap.set('n', '<Leader>mk', '<Cmd>WinShift up<CR>',       {silent=true})
vim.keymap.set('n', '<Leader>ml', '<Cmd>WinShift right<CR>',    {silent=true})
-- Resize
vim.keymap.set('n', '<Leader>rl', '30<C-W>>',                   {silent=true})
vim.keymap.set('n', '<Leader>rL', '10<C-W>>',                   {silent=true})
vim.keymap.set('n', '<Leader>rh', '30<C-W><',                   {silent=true})
vim.keymap.set('n', '<Leader>rH', '10<C-W><',                   {silent=true})
vim.keymap.set('n', '<Leader>rj', '5<C-W>+',                    {silent=true})
vim.keymap.set('n', '<Leader>rJ', '15<C-W>+',                   {silent=true})
vim.keymap.set('n', '<Leader>rk', '5<C-W>-',                    {silent=true})
vim.keymap.set('n', '<Leader>rK', '15<C-W>-',                   {silent=true})

vim.keymap.set('n', '<Leader>fuck', ':CellularAutomaton make_it_rain<CR>', {silent = true})

