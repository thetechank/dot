return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    opts = {
      win = {
        size = 0.3,
      },
      focus = true,
      keys ={
        ["<c-v>"] = "jump_vsplit",
        ["<c-s>"] = "jump_split",
        i = "inspect",
        p = "preview",
        P = "toggle_preview",
      },
      modes = {
        lsp = {
          win = {
            size = 0.3,
          },
        }
      }
    },

    keys = {
      { "<leader>xa", "<cmd>Trouble diagnostics toggle<CR>", desc = "[x]Trouble [a]ll diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0 <CR>", desc = "[x]Trouble [b]uffer diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "[x]Trouble [q]uickfix" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "[x]Trouble [L]oclist" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "[x]Trouble [t]odo" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=true<CR>", desc = "[x]Trouble [s]ymbols" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>", desc = "[x]Trouble [l]sp" },
    },
}
