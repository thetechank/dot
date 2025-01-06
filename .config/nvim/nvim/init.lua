vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.o.packpath = vim.o.runtimepath
vim.cmd('source ~/.vim/vimrc')

-- require("core")
-- require("lazysetup")

if vim.g.vscode then
    require("nvimvscode.core")
else
    require("ank.core")
    require("lazysetup")
    vim.cmd.colorscheme("onenord")
end
