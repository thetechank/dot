return { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
                    return
                end
                return "make install_jsregexp"
            end
            )(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    See the README about individual language/framework/plugin snippets:
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
        "saadparwaiz1/cmp_luasnip",

        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
    },
    config = function()
        -- See `:help cmp`
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.setup {}

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noinsert"
            },

            -- For an understanding of why these mappings were
            -- chosen, you will need to read `:help ins-completion`
            --
            mapping = cmp.mapping.preset.insert {
                -- Select the [n]ext item
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ['<Down>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<Up>"] = cmp.mapping.select_prev_item(),
                -- Scroll the documentation window [b]ack / [f]orward
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
                -- Will overload this later o get copilot suggestions
                -- ["<TAB>"] = cmp.mapping.confirm({
                --     behavior = cmp.ConfirmBehavior.Replace,
                --     select = false
                -- }),
                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ["<C-Space>"] = cmp.mapping.complete {},

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that"s like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),
                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

                -- Overload tab to accept Copilot suggestions.
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local copilot = require("copilot.suggestion")

                    if copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                    --  cmp.select_next_item()
                        cmp.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = false
                        })
                    -- elseif luasnip.expand_or_locally_jumpable() then
                    --     luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                -- ['<S-Tab>'] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif luasnip.expand_or_locally_jumpable(-1) then
                --         luasnip.jump(-1)
                --     else
                --         fallback()
                --     end
                -- end, { 'i', 's' }),

                -- Use <Esc> to close the completion menu without confirming
                ['<Esc>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()  -- Closes the cmp window without selecting
                    else
                        fallback()  -- Fallback to normal Esc behavior
                    end
                end, { 'i', 's' }),
            },

            sources = {
                {
                    name = "lazydev",
                    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                    group_index = 0,
                },
                { 
                    name = "copilot",
                    --group_index = 2 
                },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" }, -- text within current buffer
                { name = "path" },
            },

            formatting = {
                format = function(entry, vim_item)
                    --   vim_item.kind = ({
                    --     copilot = "[Copilot]",
                    --     luasnip = "[snip]",
                    --     nvim_lsp = "[LSP]",
                    --     nvim_lua = "[vim]",
                    --     buffer = "[Buffer]",
                    --     path = "[Path]",
                    --   })[entry.source.name]
                    vim_item.menu = ({
                        copilot = "[Copilot]",
                        luasnip = "[snip]",
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        nvim_lua = "[vim]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
        })

        cmp.event:on("menu_opened", function()
            vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function()
            vim.b.copilot_suggestion_hidden = false
        end)
    end,

}
