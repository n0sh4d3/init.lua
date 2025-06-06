return {
    {
        "neovim/nvim-lspconfig",
        event = "BufEnter *.*",
        dependencies = {
            {
                "williamboman/mason.nvim",
                cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
            },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {}, enabled = false },
        },

        config = function()
            -- ╭──────────────────────────────────────────────╮
            -- │ TokyoNight LSP Setup — Plug in to the Grid ⚡ │
            -- ╰──────────────────────────────────────────────╯

            -- 🌐 Attach LSP features on demand
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("tokyonight-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, {
                            buffer = event.buf,
                            desc = "LSP: " .. desc,
                        })
                    end

                    -- 🛰️ LSP Telescope-Powered Navigation
                    map("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("<leader>td", require("telescope.builtin").lsp_type_definitions, "[T]ype [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                    -- 🛠️ Core LSP features
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>hr", vim.lsp.buf.hover, "[H]over [D]ocumentation")
                    map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- 🧠 Smarter Capabilities (With Completion)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities,
                require("cmp_nvim_lsp").default_capabilities())

            -- 🛸 Server Configuration: Language Modules
            local servers = {
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            staticcheck = true,
                            completeUnimported = true,
                            usePlaceholders = true,
                            codelenses = {
                                generate = true,
                                refrences = true,
                            },
                            hints = {
                                assignVariableTypes    = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes  = true,
                                constantValues         = true,
                                functionTypeParameters = true,
                                parameterNames         = true,
                                rangeVariableTypes     = true,
                            },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
            }

            -- 🔧 Mason & Friends: Set up everything
            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers)
            vim.list_extend(ensure_installed, {
                "gopls",
                "stylua",
                "clangd",
                "clang-format",
                "rust-analyzer",
            })

            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
            })

            -- 🔌 LSP Server Plug-In Point
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
