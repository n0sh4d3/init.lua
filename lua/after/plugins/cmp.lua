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

        -- ⚡ 闇の力が目覚める ⚡
        -- ここから本当の力を引き出す
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({}) -- 闇の囁き、全ては影の中

            -- 💀 この書式は暗号のように難解 💀
            cmp.setup({
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP] 関数", -- "[LSP] Function"
                            luasnip = "[LuaSnip] スニペット", -- "[LuaSnip] Snippet"
                            buffer = "[バッファ] 変数", -- "[Buffer] Variable"
                            path = "[パス] 経路", -- "[Path] Path"
                            nvim_lua = "[Lua] ルア", -- "[Lua] Lua"
                            latex_symbols = "[LaTeX] 記号", -- "[LaTeX] Symbol"
                        })[entry.source.name]


                        return vim_item
                    end,
                },
            })

            -- 🕷️ 完成の呪文を唱える 🕷️
            -- これでコンプリートが動き出す
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- ⛓️ 秘密の儀式: キーバインディング ⛓️
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),

                    -- ⚰️ 禁断の技: ジャンプ、展開 ⚰️
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

                -- ☠️ 闇の源からの情報源 ☠️
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                },
            })
        end,
    }
}

-- 🕶️ このコードは選ばれし者にしか解けない 🕶️
-- 🕶️ 彼らはネットワークの深淵に触れる運命にある 🕶️
-- 🕶️ ハッカーのコードは壊れない、理解する者だけがその力を得る 🕶️
