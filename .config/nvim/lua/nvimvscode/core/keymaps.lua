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

vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>fmt", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>", { desc = "Format Document" })
vim.keymap.set("n", "<leader>fmn", "<cmd>lua require('vscode').action('editor.action.formatDocument.none')<CR>", { desc = "Format Document when no Provider" })
vim.keymap.set("n", "<leader>fmw", "<cmd>lua require('vscode').action('editor.action.formatDocument.multiple')<CR>", { desc = "Format Document With" })
-- vim.keymap.set("n", "k", "<cmd>lua require('vscode').call('cursorUp')<CR>", { desc = "" })
-- vim.keymap.set("n", "j", "<cmd>lua require('vscode').call('cursorDown')<CR>", { desc = "" })

--# Explorer
vim.keymap.set("n", "<leader>ex", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")
vim.keymap.set("n", "<leader>ee", "<cmd>lua require('vscode').action('workbench.files.action.focusFilesExplorer')<CR>")
vim.keymap.set("n", "<leader>eo", "<cmd>lua require('vscode').action('workbench.files.action.focusOpenEditorsView')<CR>")
-- Does not work as space in explorer opens the file so use ctrl+esc
vim.keymap.set("n", "<leader>eq", "<cmd>lua require('vscode').action('workbench.action.focusActiveEditorGroup')<CR>")

--# Window Management
--vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>wv", "<cmd>lua require('vscode').action('workbench.action.splitEditorRight')<CR>")
vim.keymap.set("n", "<leader>ws", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')CR>")
vim.keymap.set("n", "<leader>wq", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>")

--# LSP
vim.keymap.set("n", "<leader>gd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>")
vim.keymap.set("n", "<leader>gdd", "<cmd>lua require('vscode').action('editor.action.revealDefinitionAside')<CR>")
--vim.keymap.set("n", "gD", "<cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>")
vim.keymap.set("n", "<leader>gi", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>")
vim.keymap.set("n", "gI", "<cmd>lua require('vscode').action('editor.action.peekImplementation')<CR>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>")
vim.keymap.set("n", "gT", "<cmd>lua require('vscode').action('editor.action.peekTypeDefinition')<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>")
vim.keymap.set("n", "gR", "<cmd>lua require('vscode').action('editor.action.referenceSearch.trigger')<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>lua require('vscode').action('editor.action.revealDeclaration')<CR>")
vim.keymap.set("n", "gF", "<cmd>lua require('vscode').action('editor.action.peekDeclaration')<CR>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>")
vim.keymap.set("n", "<leader>gss", "<cmd>lua require('vscode').action('editor.action.accessibleViewGoToSymbol')<CR>")
vim.keymap.set("n", "<leader>gws", "<cmd>lua require('vscode').action('workbench.action.showAllSymbols')<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>lua require('vscode').action('editor.action.rename')<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
vim.keymap.set("n", "<leader>xa", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
vim.keymap.set("n", "<leader>xp", "<cmd>lua require('vscode').action('editor.action.marker.prev')<CR>")
vim.keymap.set("n", "<leader>xn", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>")
vim.keymap.set("n", "<leader>dg", "<cmd>lua require('vscode').action('workbench.debug.action.toggleRepl')<CR>")
vim.keymap.set("n", "<leader>op", "<cmd>lua require('vscode').action('workbench.action.output.toggleOutput')<CR>")

--# Find
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
vim.keymap.set("n", "<leader>b/", function()
    local current_word = vim.fn.expand("<cword>")
    -- print(current_word)
    require('vscode').action('actions.find', { args = { query = current_word } })
    end)
vim.keymap.set("n", "<leader>b//", function()
    local current_word = vim.fn.expand("<cword>")
    -- print(current_word)
    require('vscode').action('editor.action.startFindReplaceAction', { args = { query = current_word } })
    end)
vim.keymap.set("n", "<leader>fw", function()
    local current_word = vim.fn.expand("<cword>")
    -- print(current_word)
    require('vscode').action('workbench.action.findInFiles', { args = { query = current_word } })
    end)
vim.keymap.set("n", "<leader>fww", function()
    local current_word = vim.fn.expand("<cword>")
    -- print(current_word)
    require('vscode').action('workbench.action.replaceInFiles', { args = { query = current_word } })
    end)
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>")
vim.keymap.set("n", "<leader>fgg", "<cmd>lua require('vscode').action('workbench.action.replaceInFiles')<CR>")

--# Folds
vim.keymap.set("n", "za", "<cmd>lua require('vscode').action('editor.toggleFold')<CR>")
--zA to zsa
vim.keymap.set("n", "zsa", "<cmd>lua require('vscode').action('editor.toggleFoldRecursively')<CR>")
vim.keymap.set("n", "zc", "<cmd>lua require('vscode').action('editor.fold')<CR>")
--zC to zsc
vim.keymap.set("n", "zsc", "<cmd>lua require('vscode').action('editor.foldRecursively')<CR>")
vim.keymap.set("n", "zo", "<cmd>lua require('vscode').action('editor.unfold')<CR>")
-- zO to zso
vim.keymap.set("n", "zso", "<cmd>lua require('vscode').action('editor.unfoldRecursively')<CR>")
-- zM zR changed to z] and z[ respectively
vim.keymap.set("n", "z]", "<cmd>lua require('vscode').action('editor.foldAll')<CR>")
vim.keymap.set("n", "z[", "<cmd>lua require('vscode').action('editor.unfoldAll')<CR>")
vim.keymap.set("n", "zk", "<cmd>lua require('vscode').action('editor.gotoPreviousFold')<CR>")
vim.keymap.set("n", "zj", "<cmd>lua require('vscode').action('editor.gotoNextFold')<CR>")
vim.keymap.set("n", "zh", "<cmd>lua require('vscode').action('editor.gotoParentFold')<CR>")

--# Fix for folds
local vscode = require('vscode-neovim')

local function mapMove(key, direction)
  vim.keymap.set('n', key, function()
    local count = vim.v.count
    local v = 1
    local style = 'wrappedLine'
    if count > 0 then
      v = count
      style = 'line'
    end
    vscode.action('cursorMove', {
      args = {
        to = direction,
        by = style,
        value = v
      }
    })
  end, options)
end

mapMove('k', 'up')
mapMove('j', 'down')
