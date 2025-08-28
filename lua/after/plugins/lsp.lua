return {
    -- =================== COMPLETION ===================
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help", -- slim param popup
            "windwp/nvim-autopairs",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local types = require("cmp.types")
            local luasnip = require("luasnip")

            require("luasnip.loaders.from_vscode").lazy_load()
            require("nvim-autopairs").setup({})

            cmp.setup({
                completion = { completeopt = "menu,menuone,noinsert" },
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
                    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" }, -- slim inline signatures
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                }),
            })

            -- one pair of () on confirm + immediately re-open cmp to show signature
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", function(event)
                local item = event.entry:get_completion_item()
                local k = item and item.kind
                if k == types.lsp.CompletionItemKind.Function
                    or k == types.lsp.CompletionItemKind.Method then
                    cmp_autopairs.on_confirm_done()(event)
                    vim.schedule(function()
                        if vim.api.nvim_get_mode().mode:match("[is]") then
                            cmp.complete({ reason = cmp.ContextReason.Auto })
                        end
                    end)
                end
            end)
        end,
    },

    -- =================== LSP CORE (with Telescope ui-select) ===================
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            { "williamboman/mason.nvim", cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" } },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim",       opts = {},                                                          enabled = false },
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            -- never pause on long messages
            vim.opt.more = false
            vim.opt.shortmess:append("FWIc")

            -- diagnostics tidy - DISABLE ALL VISUAL INDICATORS
            vim.diagnostic.config({
                virtual_text = true, -- No inline text
                signs = true,        -- No gutter signs
                underline = true,    -- No underlines
                update_in_insert = true,
                severity_sort = true,
                -- float = {
                --     border = "rounded",
                --     source = "if_many",
                --     focusable = false,
                --     style = "minimal", -- Consistent with telescope
                --     header = "",       -- Clean header
                -- },
            })

            -- Automatically close diagnostic lists when diagnostics change
            vim.api.nvim_create_autocmd("DiagnosticChanged", {
                callback = function()
                    local ll = vim.fn.getloclist(0, { winid = 1 }); if ll and ll.winid and ll.winid ~= 0 then
                        vim.cmd("lclose")
                    end
                    local qf = vim.fn.getqflist({ winid = 1 }); if qf and qf.winid and qf.winid ~= 0 then
                        vim.cmd("cclose")
                    end
                end,
            })

            -- attach goodies
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("tokyonight-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- telescope nav
                    map("<leader>gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("<leader>gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map("<leader>td", require("telescope.builtin").lsp_type_definitions, "[T]ype [D]efinition")
                    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                    -- core
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>hr", vim.lsp.buf.hover, "[H]over [Docs]")
                    map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction (Telescope)")

                    -- diagnostics with telescope-style picker
                    map("<leader>q", function()
                        require("telescope.builtin").diagnostics({
                            bufnr = 0,
                            severity_limit = vim.diagnostic.severity.HINT,
                        })
                    end, "Show diagnostic [E]rror messages (Telescope)")

                    -- signatures (manual only)
                    vim.keymap.set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help,
                        { buffer = event.buf, desc = "LSP: Signature Help" })

                    -- NO document highlights to keep buffer clean
                    -- Removed the document highlight autocmds

                    -- Enable inlay hints only for Go (gopls) for consistency
                    local c = vim.lsp.get_client_by_id(event.data.client_id)
                    if c and c.name == "gopls" and c.server_capabilities.inlayHintProvider then
                        if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
                            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = event.buf })
                        elseif vim.lsp.inlay_hint then
                            pcall(vim.lsp.inlay_hint, event.buf, true)
                        end
                    end
                end,
            })

            -- capabilities
            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- servers with consistent inlay hint settings
            local servers = {
                gopls         = {
                    cmd = { "gopls" },
                    handlers = {
                        ["window/showMessage"] = function() end,
                        ["window/logMessage"]  = function() end,
                        ["$/logTrace"]         = function() end,
                    },
                    settings = {
                        gopls = {
                            verboseOutput = false,
                            analyses = { unusedparams = true, shadow = true },
                            staticcheck = true,
                            completeUnimported = true,
                            usePlaceholders = true,
                            codelenses = { generate = true, refrences = true },
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
                    capabilities = capabilities,
                },

                rust_analyzer = {
                    capabilities = capabilities,
                    settings = {
                        ["rust-analyzer"] = {
                            inlayHints = {
                                bindingModeHints = { enable = false },
                                chainingHints = { enable = false },
                                closingBraceHints = { enable = false },
                                closureReturnTypeHints = { enable = "never" },
                                lifetimeElisionHints = { enable = "never" },
                                maxLength = 25,
                                parameterHints = { enable = false }, -- Use signature help instead
                                reborrowHints = { enable = "never" },
                                renderColons = true,
                                typeHints = { enable = false },
                            },
                        },
                    },
                },

                pyright       = {
                    capabilities = capabilities,
                    settings = {
                        python = {
                            analysis = {
                                inlayHints = {
                                    variableTypes = false,
                                    functionReturnTypes = false,
                                    parameterNames = true, -- Disable to avoid duplicates with signature help
                                    parameterTypes = true,
                                },
                            },
                        },
                    },
                },

                clangd        = {
                    capabilities = capabilities,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        "--enable-config",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },

                lua_ls        = {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            completion = { callSnippet = "Replace" },
                            hint = {
                                enable = false, -- Use signature help instead for consistency
                            },
                        },
                    },
                },
            }

            -- Mason bootstrap & ensure tools
            require("mason").setup()
            local ensure = vim.tbl_keys(servers)
            vim.list_extend(ensure, { "stylua", "clang-format", "ruff" })
            require("mason-tool-installer").setup({ ensure_installed = ensure })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or { capabilities = capabilities }
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
