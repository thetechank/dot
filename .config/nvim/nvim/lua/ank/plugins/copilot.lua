return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        opts = {
            -- I don't find the panel useful.
            panel = { 
                enabled = false 
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                -- Use alt to interact with Copilot.
                keymap = {
                    -- Disable the built-in mapping, we'll configure it in nvim-cmp.
                    accept = '<M-a>',
                    accept_word = '<M-w>',
                    accept_line = '<M-l>',
                    next = '<M-]>',
                    prev = '<M-[>',
                    dismiss = '<ESC>',
                },
            },
            --filetypes = { markdown = true },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { 
            "zbirenbaum/copilot.lua" 
        },
        config = function()
            require("copilot_cmp").setup()
        end,
    }
}
