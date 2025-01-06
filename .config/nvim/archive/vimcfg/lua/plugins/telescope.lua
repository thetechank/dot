actions = require('telescope.actions')

mappings = {
    i = {
        ["<esc>"] = actions.close,
        ["<C-v>"] = actions.select_vertical,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-d>"] = actions.delete_buffer,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

require('telescope').setup {
    defaults = { mappings = mappings },
    pickers = {
        find_files = {},
        git_files = {},
        lsp_references = {}
    },
}

local MAX_HORIZONTAL_WIDTH = 200

-- TODO: use this
function picker_theme() 
    if vim.o.columns < MAX_HORIZONTAL_WIDTH then
        return {
            layout_strategy = "vertical",
            layout_config = { 
                height = 0.8,
                preview_cutoff = 40,
            }
        }
    else
        return {
            layout_strategy = "horizontal",
            layout_config = {
                height = 0.8,
                preview_cutoff = 40,
                prompt_position = "top",
                width = 0.8
            }
        }
    end
end

function build_picker(picker_f, opts)
    return function() 
        all_opts = picker_theme()
        for k,v in pairs(opts) do all_opts[k] = v end
        picker_f(all_opts) 
    end
end


require("telescope").load_extension("ui-select")
require("telescope").load_extension("undo")
tele = require('telescope.builtin')

-- Calls telescope git_files if in a git repo,
-- calls telescope find_files otherwise
function TS_git_with_fallback()
    local rv_ok = pcall(build_picker(tele.git_files, {}))
    if not rv_ok then build_picker(tele.find_files, {})() end
end

function ts_symbols(symbol_type)
    return build_picker(
        require'telescope.builtin'.treesitter, 
        { symbols = symbol_type }
    )
end

vim.keymap.set('n', '<Leader>fa', TS_git_with_fallback)
vim.keymap.set('n', '<Leader>fA', build_picker(tele.find_files, {}))
vim.keymap.set('n', '<Leader>fg', build_picker(tele.live_grep, {}))
vim.keymap.set('n', '<Leader>fb', build_picker(tele.buffers, {}))
vim.keymap.set('n', '<Leader>fo', build_picker(tele.jumplist, {}))
vim.keymap.set('n', '<Leader>ff', build_picker(tele.resume, {}))
vim.keymap.set('n', '<Leader>fm', build_picker(tele.marks, {}))
vim.keymap.set("n", "<leader>fu", build_picker(require'telescope'.extensions.undo.undo, {}))
vim.keymap.set('n', '<Leader>fsf', ts_symbols('function'))
vim.keymap.set('n', '<Leader>fsv', ts_symbols('var'))
vim.keymap.set('n', '<Leader>fsp', ts_symbols('parameter'))
