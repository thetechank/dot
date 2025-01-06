return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- Ensure parsers are kept up-to-date
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
        ensure_installed = {
            "json",
            "javascript",
            "typescript",
            "tsx",
            "yaml",
            "html",
            "css",
            "prisma",
            "markdown",
            "markdown_inline",
            "svelte",
            "graphql",
            "bash",
            "lua",
            "vim",
            "dockerfile",
            "gitignore",
            "query",
            "vimdoc",
            "c",
            "python"
          },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
            enable = true,             -- Enable syntax highlighting
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,             -- Enable indenting based on Treesitter
        },
        -- autotag = {
        --     enable = true,
        --   },
        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    },
    -- config = function (_,opts) 
    --     local configs = require("nvim-treesitter.configs")
    --     configs.setup(opts)
    -- end
  }
  