return {
    -- =================== UI POPUPS FOR RENAME/SELECT ===================
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                enabled = true,
                border = "none", -- ❌ remove border, like cmp
                relative = "cursor",
                prefer_width = 40,
                win_options = {
                    -- Reuse the same highlights as cmp/lsp menus
                    winblend = 0,
                    winhighlight = table.concat({
                        "Normal:Pmenu",      -- same bg as cmp popup
                        "FloatBorder:Pmenu", -- border hidden anyway
                        "CursorLine:PmenuSel",
                        "Search:None",
                    }, ","),
                },
            },
            select = {
                enabled = true,
                backend = { "telescope", "builtin" },
                builtin = {
                    border = "none",
                    win_options = {
                        winblend = 0,
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    },
                },
                -- FIX: Use centered layout like main telescope pickers
                telescope = {
                    border = false,
                    borderchars = { "", "", "", "", "", "", "", "" },
                    winblend = 0,
                    prompt_title = false,
                    results_title = false,
                    preview_title = false,
                    previewer = false,
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.6,       -- bigger and centered
                        height = 0.4,      -- taller
                        preview_width = 0, -- no preview needed
                    },
                },
            },
        },
    },


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

    -- =================== LSP CORE (COMPLETELY SILENT) ===================
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
            -- COMPLETE MESSAGE SUPPRESSION
            vim.opt.more = false
            vim.opt.shortmess:append("FWIcaATI")

            -- DISABLE ALL LSP LOGGING
            vim.lsp.set_log_level("OFF")

            -- COMPLETE DIAGNOSTIC SUPPRESSION
            vim.diagnostic.config({
                virtual_text = true, -- NO inline diagnostic text
                signs = true,        -- NO gutter signs
                underline = true,    -- NO underlines
                update_in_insert = false,
                severity_sort = false,
                float = false, -- NO floating diagnostic windows
            })

            -- SUPPRESS ALL NOTIFICATIONS
            local original_notify = vim.notify
            vim.notify = function(msg, level, opts)
                -- Block ALL LSP-related messages
                if msg and (
                        string.find(msg, "LSP") or
                        string.find(msg, "gopls") or
                        string.find(msg, "RPC") or
                        string.find(msg, "expected") or
                        string.find(msg, "Error") or
                        string.find(msg, "code_name") or
                        string.find(msg, "diagnostic") or
                        string.find(msg, "rust") or
                        string.find(msg, "clangd") or
                        string.find(msg, "pyright")
                    ) then
                    return -- BLOCK IT
                end
                return original_notify(msg, level, opts)
            end

            -- Only close quickfix/loclist windows if they're diagnostic-related
            vim.api.nvim_create_autocmd("BufWinEnter", {
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
                    if ft == "qf" then
                        vim.schedule(function()
                            pcall(vim.cmd, "close")
                        end)
                    end
                end,
            })

            -- SILENT MESSAGE HANDLER
            local function silent_handler() end

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

                    -- diagnostics with telescope (clean config)
                    map("<leader>q", function()
                        require("telescope.builtin").diagnostics({
                            bufnr = 0,
                            severity_limit = vim.diagnostic.severity.HINT,
                        })
                    end, "Show diagnostic messages")

                    map("<leader>a", function()
                        vim.diagnostic.open_float({
                            bufnr = 0,
                            scope = "line", -- 👈 Works anywhere on the line with error
                            focusable = true,
                            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                            -- border = "single", -- 👈 Same as LSP hover
                            source = true, -- 👈 Clean like LSP hover
                            prefix = "",   -- 👈 No prefix like LSP hover
                            header = "",   -- 👈 No header like LSP hover
                            format = function(diagnostic)
                                return diagnostic.message
                            end,
                        })
                    end, "Show full diagnostic message")

                    -- signatures (manual only)
                    vim.keymap.set({ "i", "n" }, "<C-s>", vim.lsp.buf.signature_help,
                        { buffer = event.buf, desc = "LSP: Signature Help" })

                    -- NO inlay hints for ANYONE - they cause messages
                    -- Completely removed inlay hint code
                end,
            })

            -- capabilities
            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- servers with COMPLETE MESSAGE SUPPRESSION
            local servers = {
                gopls         = {
                    cmd = { "gopls" },
                    handlers = {
                        -- BLOCK ALL MESSAGE TYPES
                        ["window/showMessage"] = silent_handler,
                        ["window/logMessage"] = silent_handler,
                        ["window/showMessageRequest"] = silent_handler,
                        ["$/logTrace"] = silent_handler,
                        ["$/progress"] = silent_handler,
                        ["textDocument/publishDiagnostics"] = silent_handler, -- KEY: blocks diagnostics
                        ["gopls/log"] = silent_handler,
                    },
                    settings = {
                        gopls = {
                            verboseOutput = false,
                            analyses = { unusedparams = false, shadow = false }, -- Disable to reduce noise
                            staticcheck = false,                                 -- Disable to reduce noise
                            completeUnimported = true,
                            usePlaceholders = true,
                            codelenses = { generate = false, refrences = false }, -- Disable codelenses
                            hints = {
                                assignVariableTypes    = false,
                                compositeLiteralFields = false,
                                compositeLiteralTypes  = false,
                                constantValues         = false,
                                functionTypeParameters = false,
                                parameterNames         = false,
                                rangeVariableTypes     = false,
                            },
                        },
                    },
                    capabilities = capabilities,
                },

                rust_analyzer = {
                    handlers = {
                        ["window/showMessage"] = silent_handler,
                        ["window/logMessage"] = silent_handler,
                        ["textDocument/publishDiagnostics"] = silent_handler,
                        ["$/progress"] = silent_handler,
                    },
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
                                parameterHints = { enable = false },
                                reborrowHints = { enable = "never" },
                                renderColons = true,
                                typeHints = { enable = false },
                            },
                        },
                    },
                },

                pyright       = {
                    handlers = {
                        ["window/showMessage"] = silent_handler,
                        ["window/logMessage"] = silent_handler,
                        ["textDocument/publishDiagnostics"] = silent_handler,
                        ["$/progress"] = silent_handler,
                    },
                    capabilities = capabilities,
                    settings = {
                        python = {
                            analysis = {
                                inlayHints = {
                                    variableTypes = false,
                                    functionReturnTypes = false,
                                    parameterNames = false,
                                    parameterTypes = false,
                                },
                            },
                        },
                    },
                },

                clangd        = {
                    handlers = {
                        ["window/showMessage"] = silent_handler,
                        ["window/logMessage"] = silent_handler,
                        ["textDocument/publishDiagnostics"] = silent_handler,
                        ["$/progress"] = silent_handler,
                    },
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
                        "--log=error", -- Minimal logging
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = false, -- Disable status messages
                    },
                },

                lua_ls        = {
                    handlers = {
                        ["window/showMessage"] = silent_handler,
                        ["window/logMessage"] = silent_handler,
                        ["textDocument/publishDiagnostics"] = silent_handler,
                        ["$/progress"] = silent_handler,
                    },
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            completion = { callSnippet = "Replace" },
                            hint = { enable = false },
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
                        local server = servers[server_name] or {
                            capabilities = capabilities,
                            handlers = {
                                ["window/showMessage"] = silent_handler,
                                ["window/logMessage"] = silent_handler,
                                ["textDocument/publishDiagnostics"] = silent_handler,
                                ["$/progress"] = silent_handler,
                            }
                        }
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
