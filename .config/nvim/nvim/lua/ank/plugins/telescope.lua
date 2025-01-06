return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim"
    },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      "nvim-tree/nvim-web-devicons",
      enabled = vim.g.have_nerd_font,
    },
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-v>"] = actions.select_vertical,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab,
            ["<C-x>"] = actions.delete_buffer,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-x>"] = trouble_telescope.open,
            ["<C-x><C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- ["<C-u>"] = actions.preview_scrolling_up,
            -- ["<C-d>"] = actions.preview_scrolling_down,
            -- ["<C-f>"] = actions.preview_scrolling_left,
            -- ["<C-b>"] = actions.preview_scrolling_right,
            -- ["<PageUp>"] = actions.results_scrolling_up,
            -- ["<PageDown>"] = actions.results_scrolling_down,
            -- ["<M-f>"] = actions.results_scrolling_left,
            -- ["<M-b>"] = actions.results_scrolling_right,
          },
          n = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-v>"] = actions.select_vertical,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-t>"] = actions.select_tab,
            ["<C-x>"] = actions.delete_buffer,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<M-x>"] = trouble_telescope.open,
            ["<C-x><C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            -- ["<C-u>"] = actions.preview_scrolling_up,
            -- ["<C-d>"] = actions.preview_scrolling_down,
            -- ["<C-f>"] = actions.preview_scrolling_left,
            -- ["<C-b>"] = actions.preview_scrolling_right,
            -- ["<PageUp>"] = actions.results_scrolling_up,
            -- ["<PageDown>"] = actions.results_scrolling_down,
            -- ["<M-f>"] = actions.results_scrolling_left,
            -- ["<M-b>"] = actions.results_scrolling_right,
          },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension('fzf'))
    pcall(require('telescope').load_extension('ui-select'))

    local MAX_HORIZONTAL_WIDTH = 200

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
        for k, v in pairs(opts) do all_opts[k] = v end
        picker_f(all_opts)
      end
    end

    local function ts_symbols(symbol_type)
      return build_picker(
        require 'telescope.builtin'.treesitter,
        { symbols = symbol_type }
      )
    end

    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
    local find_files_opts = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    }

    -- Calls telescope git_files if in a git repo,
    -- calls telescope find_files otherwise
    function TS_git_with_fallback()
      local rv_ok = pcall(build_picker(builtin.git_files, {}))
      if not rv_ok 
      then 
        build_picker(builtin.find_files, find_files_opts)()
      end
    end

    -- set keymaps correctly using Lua functions
    local keymap = vim.keymap -- for conciseness

    --vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })

    vim.keymap.set('n', '<leader>f?', build_picker(builtin.help_tags, {}), { desc = '[f]ind [?]help' })
    vim.keymap.set('n', '<leader>ff', build_picker(builtin.find_files, find_files_opts), { desc = '[f]ind [f]iles' })
    vim.keymap.set('n', '<leader>fF', TS_git_with_fallback, { desc = '[f]ind git [F]iles' })
    vim.keymap.set('n', '<leader>fb', build_picker(builtin.buffers, {}), { desc = '[f]ind existing [b]uffers' })
    vim.keymap.set('n', '<leader>fw', build_picker(builtin.grep_string, {}), { desc = '[f]ind current [w]ord' })
    vim.keymap.set('n', '<leader>fg', build_picker(builtin.live_grep, {}), { desc = '[f]ind by [g]rep' })
    vim.keymap.set('n', '<leader>fd', build_picker(builtin.diagnostics, {}), { desc = '[f]ind [d]iagnostics' })
    vim.keymap.set('n', '<leader>fr', build_picker(builtin.resume, {}), { desc = '[f]ind [r]esume' })
    vim.keymap.set('n', '<leader>f.', build_picker(builtin.oldfiles, {}),{ desc = '[f]ind in recent files ("." for repeat)' })
    vim.keymap.set('n', '<leader>fj', build_picker(builtin.jumplist, {}), { desc = '[f]ind existing [j]umplist' })
    vim.keymap.set("n", "<leader>ftd", "<cmd>TodoTelescope<cr>", { desc = "[f]ind [t]o[d]os" })
    vim.keymap.set('n', '<Leader>sf', ts_symbols('function'), { desc = '[f]ind symbols [f]unction' })
    vim.keymap.set('n', '<Leader>sv', ts_symbols('var'), { desc = '[f]ind symbols [v]ariables' })
    vim.keymap.set('n', '<Leader>sp', ts_symbols('parameter'), { desc = '[f]ind symbols [p]arameter' })

    -- Slightly advanced example of overriding default behavior and theme.You can pass additional configuration to Telescope to change the theme, layout, etc.
    vim.keymap.set('n', '<leader>b/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[f]ind [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files({ cwd = vim.fn.stdpath 'config' })
    end, { desc = '[f]ind [n]eovim files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fng', function()
      builtin.live_grep({ cwd = vim.fn.stdpath 'config' })
    end, { desc = '[f]ind [n]eovim files' })
  end, --config = function() end
}

-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of `help_tags` options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
