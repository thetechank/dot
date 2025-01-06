-- vim.lsp.set_log_level("debug")

local nvim_lsp = require('lspconfig')
local tele = require('telescope.builtin')
local preview = require('goto-preview')

binds = {
    { key = '<Leader>gpd'   ,   action = preview.goto_preview_definition },
    { key = '<Leader>gpi'   ,   action = preview.goto_preview_implementation },
    { key = '<Leader>gP'    ,   action = preview.close_all_win },
    { key = '<Leader>gpr'   ,   action = preview.goto_preview_references },
    
    { key = '<Leader>vgd'   ,   action = function() vsplit_lsp(vim.lsp.buf.definition) end },
    { key = '<Leader>vgi'   ,   action = function() vsplit_lsp(vim.lsp.buf.implementation) end },
    { key = '<Leader>vgt'   ,   action = function() vsplit_lsp(vim.lsp.buf.type_definition) end },

    { key = '<Leader>gD'    ,   action = vim.lsp.buf.declaration },
    { key = '<Leader>gd'    ,   action = tele.lsp_definitions },
    { key = '<Leader>i'     ,   action = vim.lsp.buf.hover },
    { key = '<Leader>gi'    ,   action = vim.lsp.buf.implementation },
    { key = '<Leader>gt'    ,   action = tele.lsp_type_definitions },
    { key = '<Leader>rn'    ,   action = vim.lsp.buf.rename },
    { key = '<Leader>a'     ,   action = vim.lsp.buf.code_action },
    { key = '<Leader>d'     ,   action = vim.diagnostic.open_float },
    { key = '<Leader>gr'    ,   action = tele.lsp_references },
    { key = '<Leader>gci'   ,   action = tele.lsp_incoming_calls },
    { key = '<Leader>gco'   ,   action = tele.lsp_outgoing_calls },
    { key = '<Leader>q'     ,   action = vim.diagnostic.setloclist },

    { key = '<Leader>el'    ,   action = function() tele.diagnostics({bufnr=0}) end },
    { key = '<Leader>ep'    ,   action = vim.diagnostic.goto_prev },
    { key = '<Leader>en'    ,   action = vim.diagnostic.goto_next },

    { key = '<Leader>fmt'    ,  action = vim.lsp.buf.format },
}

local opts = { noremap=true, silent=true, buffer=bufnr }

function set_lsp_binds(self, bufnr)
    for i,mapping in ipairs(binds) do
        vim.keymap.set('n', mapping.key, mapping.action, opts)
    end
end

-- Borders around LSP hovers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "single" }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = "single" }
)

local servers = { 
    'hls', 
    'clangd', 
    'eslint', 
    'tsserver',
    'pyright',
    'gopls',
    'solargraph',
    'gopls',
}

local on_attach = function(client, bufnr)
    set_lsp_binds(bufnr)
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Separate due to settings table
require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    settings = { ['rust-analyzer'] = { checkOnSave = { command = "clippy" } } }
}

function sh_fmt()
    cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd('%!shfmt')
    vim.api.nvim_win_set_cursor(0, cursor)
end

require'lspconfig'.bashls.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.keymap.set('n', '<Leader>fmt', sh_fmt, opts)
    end,
}

function python_fmt()
    cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd('%!black -q -')
    vim.api.nvim_win_set_cursor(0, cursor)
end

require'lspconfig'.pylsp.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.keymap.set('n', '<Leader>fmt', python_fmt, opts)
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.renameProvider = false
    end,

    settings = {
        pylsp = {
            plugins = {
                pyflakes = { enabled = true },
                autopep8 = { enabled = true },
                pycodestyle = { enabled = true, maxLineLength = 80 },
            }
        }
    }
}


for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

require('goto-preview').setup({ height = 25 })
require('nvim-treesitter.configs').setup({ 
    highlight = { enable = true } 
})

-- Fold workaround: 
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
vim.api.nvim_create_autocmd(
    { 'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter' }, 
    { 
        group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
        callback = function()
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
        end
    }
)

local tele = require('telescope.builtin')
local preview = require('goto-preview')
        
function vsplit_lsp(action)
    action()
    vim.cmd("vs#")
end 

vim.diagnostic.config({
  virtual_text = {
    source = "always",  -- Or "if_many"
  },
  float = {
    source = "always",  -- Or "if_many"
  },
})
