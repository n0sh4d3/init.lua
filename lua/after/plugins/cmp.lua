return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            -- Vibrant Custom Highlights for Dopamine Boost
            vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#7aa2f7", bg = "#1f2335" })
            vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "#292e42" })
            vim.api.nvim_set_hl(0, "CmpSel", { bg = "#bb9af7", fg = "#1f2335", bold = true })
            vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#c0caf5", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#7dcfff", bold = true })
            vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#c3e88d", bg = "#414868", bold = true })
            vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#ff9e64", italic = true })

            -- Define highlight groups for item kinds
            local kind_highlights = {
                Text = "CmpItemKindText",
                Method = "CmpItemKindMethod",
                Function = "CmpItemKindFunction",
                Constructor = "CmpItemKindConstructor",
                Field = "CmpItemKindField",
                Variable = "CmpItemKindVariable",
                Class = "CmpItemKindClass",
                Interface = "CmpItemKindInterface",
                Module = "CmpItemKindModule",
                Property = "CmpItemKindProperty",
                Unit = "CmpItemKindUnit",
                Value = "CmpItemKindValue",
                Enum = "CmpItemKindEnum",
                Keyword = "CmpItemKindKeyword",
                Snippet = "CmpItemKindSnippet",
                Color = "CmpItemKindColor",
                File = "CmpItemKindFile",
                Reference = "CmpItemKindReference",
                Folder = "CmpItemKindFolder",
                EnumMember = "CmpItemKindEnumMember",
                Constant = "CmpItemKindConstant",
                Struct = "CmpItemKindStruct",
                Event = "CmpItemKindEvent",
                Operator = "CmpItemKindOperator",
                TypeParameter = "CmpItemKindTypeParameter",
            }

            -- Apply colors to highlight groups
            local colors = {
                Text = "#ff9e64",
                Method = "#bb9af7",
                Function = "#b4f9f8",
                Constructor = "#7dcfff",
                Field = "#c3e88d",
                Variable = "#ffc777",
                Class = "#9d7cd8",
                Interface = "#41a6b5",
                Module = "#7aa2f7",
                Property = "#ff757f",
                Unit = "#4fd6be",
                Value = "#c53b53",
                Enum = "#ff007c",
                Keyword = "#ff757f",
                Snippet = "#9d7cd8",
                Color = "#b4f9f8",
                File = "#7aa2f7",
                Reference = "#c3e88d",
                Folder = "#7dcfff",
                EnumMember = "#ff9e64",
                Constant = "#ffc777",
                Struct = "#41a6b5",
                Event = "#bb9af7",
                Operator = "#4fd6be",
                TypeParameter = "#ff007c",
            }

            for kind, group in pairs(kind_highlights) do
                vim.api.nvim_set_hl(0, group, { fg = colors[kind], bold = true })
            end

            cmp.setup({
                view = {
                    entries = { name = "custom", selection_order = "near_cursor" },
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight =
                        "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None"
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight =
                        "Normal:CmpPmenu,FloatBorder:CmpBorder"
                    }),
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[Latex]",
                        })[entry.source.name] or ""

                        vim_item.kind_hl_group = kind_highlights[vim_item.kind] or "CmpItemKind"
                        return vim_item
                    end,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),
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
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })
        end,
    }
}
