--# Basic Keymaps
vim.keymap.set('n', '<Leader>fuck', ':CellularAutomaton make_it_rain<CR>', {silent = true})
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
-- increment/decrement numbers
-- vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--# Editing
-- Delete into the black hole register
vim.keymap.set("n", "<Del>" , '"_x')
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without affecting clipboard" })
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without affecting clipboard" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete character without affecting clipboard" })
-- Paste from system clipboard directly
vim.keymap.set("n", "<leader>P", '"+p', { desc = "Paste from system clipboard" })
-- Paste last yanked text from register 0
vim.keymap.set("n", "<leader>p", '"0p', { desc = "Paste last yanked text" })
vim.keymap.set("n", "<leader>D" , 'gg0vG"_d', { desc = "Delete whole file without affecting clipboard" })
vim.keymap.set("n", "<leader>A" , 'ggVG', { desc = "Select All" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Cut to Clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>c", '"+c', { desc = "Cut Change to Clipboard" })

vim.keymap.set('n', '<Tab>', '>', { desc = 'Indent' })
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent and Re-select' })
vim.keymap.set('n', '<S-Tab>', '<', { desc = 'Indent' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Indent and Re-select' })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })


--# Window Management
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-w>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-w>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-w>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-w>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>wq", "<C-w>c", { desc = "Close current split" }) -- close current split window

vim.keymap.set('n', '<Leader>wl', '30<C-W>>',{ desc = "[w]indow resize [l] increase width "})
vim.keymap.set('n', '<Leader>wL', '10<C-W>>',{ desc = "[w]indow resize [L] increase width"})
vim.keymap.set('n', '<Leader>wh', '30<C-W><',{ desc = "[w]indow resize [h] decrease width"})
vim.keymap.set('n', '<Leader>wH', '10<C-W><',{ desc = "[w]indow resize [H] decrease width"})
vim.keymap.set('n', '<Leader>wj', '5<C-W>+', { desc = "[w]indow resize [j] increase height"})
vim.keymap.set('n', '<Leader>wJ', '15<C-W>+',{ desc = "[w]indow resize [J] increase height"})
vim.keymap.set('n', '<Leader>wk', '5<C-W>-', { desc = "[w]indow resize [k] decrease height"})
vim.keymap.set('n', '<Leader>wK', '15<C-W>-',{ desc = "[w]indow resize [K] decrease height"})
vim.keymap.set("n", "<leader>w=", "<C-w>=",  { desc = "Make splits equal size" }) -- make split windows equal width & height

--# Tab Management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

--# Navigation
vim.keymap.set("n", "<leader><RIGHT>", '<cmd>bn<CR>', { desc = "Next Buffer" })
vim.keymap.set("n", "<leader><LEFT>", '<cmd>bp<CR>', { desc = "Previous Buffer" })
--Change becasue C-I not working in terminal
vim.keymap.set('n', '<C-P>', '<C-I>')

--# Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


--vim.keymap.set("i", "<C-h><C-h>", function() print("Hover!") end)
