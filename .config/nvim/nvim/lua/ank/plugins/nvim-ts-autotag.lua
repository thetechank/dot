return {
    "windwp/nvim-ts-autotag",
    -- keys = {
    --     { "-", "<cmd>Neotree toggle<cr>", mode = "n", desc = "NeoTree" },
    --   },
    config = function(_,opts)
        require('nvim-ts-autotag').setup({
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            per_filetype = {
                    ["html"] = {
                        enable_close = true
                    }
            },
        })
    end,

  }