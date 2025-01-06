return {
  {
    "stevearc/oil.nvim",
    -- keys = {
    --     { "-", "<cmd>Neotree toggle<cr>", mode = "n", desc = "NeoTree" },
    --   },
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand "%"
        path = path:gsub("oil://", "")

        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
          ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set("n", "<leader>ex", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<leader>ee", require("oil").toggle_float)
    end,
  },
}