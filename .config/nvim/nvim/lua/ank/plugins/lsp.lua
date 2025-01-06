return {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        {
            "williamboman/mason.nvim",
            config = true
        }, -- NOTE: Must be loaded before dependants
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
        {
            "j-hui/fidget.nvim",
            opts = {}
        },
        {
            "folke/lazydev.nvim",
            opts = {}
        },
        -- Allows extra capabilities provided by nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Brief aside: **What is LSP?**
        --
        -- LSP is an initialism you've probably heard, but might not understand what it is.
        --
        -- LSP stands for Language Server Protocol. It's a protocol that helps editors
        -- and language tooling communicate in a standardized fashion.
        --
        -- In general, you have a "server" which is some tool built to understand a particular
        -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
        -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
        -- processes that communicate with some "client" - in this case, Neovim!
        --
        -- LSP provides Neovim with features like:
        --  - Go to definition
        --  - Find references
        --  - Autocompletion
        --  - Symbol Search
        --  - and more!
        --
        -- Thus, Language Servers are external tools that must be installed separately from
        -- Neovim. This is where `mason` and related plugins come into play.
        --
        -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
        -- and elegantly composed help section, `:help lsp-vs-treesitter`

        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local function vsplit_lsp(action)
                    action()
                    vim.cmd("vs#")
                end

                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                --map("<leader>vgd", function() vsplit_lsp(vim.lsp.buf.definition) end, "[G]oto [D]efinition in [V]split")
                map("<leader>vgd",
                    function() require("telescope.builtin").lsp_definitions({ jump_type = "vsplit", reuse_win = true }) end,
                    "[G]oto [D]efinition in [V]split")
                map("<leader>gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")
                map("<leader>gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
                map("<leader>gi", require("telescope.builtin").lsp_implementations, "[g]oto [i]mplementation")
                map("<leader>gt", require("telescope.builtin").lsp_type_definitions, "[g]oto [t]ype definition")
                map("<leader>gf", vim.lsp.buf.declaration, "[g]oto [f]Declaration")

                map("<leader>gs", require("telescope.builtin").lsp_document_symbols, "[g]oto document [s]ymbols")
                map("<leader>gws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "[g]oto [w]orkspace [s]ymbols")

                map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
                map("<leader>k", vim.lsp.buf.hover, "[k]Show Hover Under Cursor")
                map("<C-h><C-h>", vim.lsp.buf.hover, "[C-k]Show Hover Under Cursor", { "i" })
                map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })

                map("<leader>xl", vim.diagnostic.open_float, "[x]diagnostics [l]ine")
                map("<leader>xp", vim.diagnostic.goto_prev, "[x]diagnostics [p]revious")
                map("<leader>xn", vim.diagnostic.goto_next, "[x]diagnostic [n]ext")
                map("<leader>da", require("telescope.builtin").diagnostics, "[d]diagnostics [a]ll")
                map("<leader>db", function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
                    "[d]iagnostics current [b]uffer")

                map("<leader>rs", ":LspRestart<CR>", "[R]estart L[S]P")
                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn"t support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --   For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            -- clangd = {},
            gopls = {},
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "standard",
                            useLibraryCodeForTypes = true,
                            autoImportCompletions = true,
                            diagnosticMode = "workspace", -- Analyze the whole workspace
                            diagnosticSeverityOverrides = {
                                -- Customize specific diagnostic severities if needed
                                --reportUnknownMemberType = "none", -- Reduce "unknown type" noise
                                --reportMissingTypeStubs = "none", -- Reduce missing stub warnings
                            },
                            extraPaths = {
                                "./src",
                                "./tests",
                            }, -- Adjust based on your project structure
                        },
                        pythonPath = (function()
                            -- Determine Python path from the virtual environment or fallback to system Python
                            local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
                            if vim.fn.executable(venv_python) == 1 then
                                return venv_python
                            end
                            return vim.fn.exepath("python")
                        end)(),
                        --venvPath = vim.fn.getcwd(),
                        --venv = ".venv",
                    },
                },
                on_attach = function(client, bufnr)
                    -- Pyright specific bindings or commands can be added here
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>oi", ":PyrightOrganizeImports<CR>",
                        { noremap = true })
                    vim.keymap.set("n", "<leader>oi", ":PyrightOrganizeImports<CR>",
                        { buffer = bufnr, desc = "LSP: " .. "Pyright Organize Imports" })
                end,
            },
            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = true },
                            autopep8 = { enabled = true },
                            pycodestyle = { enabled = true, maxLineLength = 80 },
                        }
                    },
                },
                on_attach = function(client, bufnr)
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.renameProvider = false
                end,
            },
            html = {},
            -- rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
            --
            -- Some languages (like typescript) have entire language plugins that can be useful:
            --    https://github.com/pmizio/typescript-tools.nvim
            --
            -- But for many setups, the LSP (`ts_ls`) will work just fine
            ts_ls = {},
            --

            lua_ls = {
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { "missing-fields" } },
                    },
                },
            },
        }

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu.
        require("mason").setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            "stylua", -- Used to format Lua code
            "prettier",
            "isort",
            "black",
            "pylint",
            "eslint_d",
        })
        require("mason-tool-installer").setup { ensure_installed = ensure_installed }

        require("mason-lspconfig").setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for ts_ls)
                    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                    require("lspconfig")[server_name].setup(server)
                end,
            },
        }
    end,
}

--[[ {handlers} is a table where the keys are the name of an lspconfig server,
    and the values are the function to be called when that server is ready to
    be set up (i.e. is installed).

    You may also pass a default handler that will be called when no dedicated
    handler is provided. This is done by providing a function without a key
    (see example below).

   Note: ~
       The server names provided as keys are the lspconfig server names, not
       mason's package names, so for example instead of "lua-language-server"
       it's "lua_ls".

   Example: ~
>lua
       local handlers = {
           -- The first entry (without a key) will be the default handler
           -- and will be called for each installed server that doesn't have
           -- a dedicated handler.
           function (server_name) -- default handler (optional)
               require("lspconfig")[server_name].setup {}
           end,
           -- Next, you can provide targeted overrides for specific servers.
           ["rust_analyzer"] = function ()
               require("rust-tools").setup {}
           end,
           ["lua_ls"] = function ()
               local lspconfig = require("lspconfig")
               lspconfig.lua_ls.setup {
                   settings = {
                       Lua = {
                           diagnostics = {
                               globals = { "vim" }
                           }
                       }
                   }
               }
           end,
       }

       -- alt 1. Either pass handlers when setting up mason-lspconfig:
       require("mason-lspconfig").setup({ handlers = handlers })

       -- alt 2. or call the .setup_handlers() function.
       require("mason-lspconfig").setup_handlers(handlers) ]]
