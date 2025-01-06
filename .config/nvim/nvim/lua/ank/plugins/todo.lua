-- Highlight todo, notes, etc in comments
return { 
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- keys = {
    --     { '"]t"', "<cmd>todo_comments.jump_next()<cr>", mode = "n", desc = "Next todo comment" },
    -- },
    opts = {
        signs = false 
    },
    config = function(_,opts)
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "]t", function()
          todo_comments.jump_next()
        end, { desc = "Next todo comment" })

        vim.keymap.set("n", "[t", function()
          todo_comments.jump_prev()
        end, { desc = "Previous todo comment" })

        todo_comments.setup(opts)
      end,
}