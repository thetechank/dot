return {
    {
      "williamboman/mason.nvim",
      lazy = false,
      --priority = 100,
      config = true
      
    },

    {
      "williamboman/mason-lspconfig.nvim",
      lazy = false,
      priority = 100,
      opts = {
        automatic_installation = true,
        ensure_installed = {
          "ts_ls",
          "html",
          "pyright",
        },
      },
      -- config = function(_,opts)
      --   require("mason-lspconfig").setup(opts)
      -- end
      --config = true
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    }
}