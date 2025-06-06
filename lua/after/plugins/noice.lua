return {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- enabled = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        -- Pastel color palette
        local colors = {
            fg = "#e0e0e0",        -- Light foreground
            blue = "#B2CFED",      -- PASTEL_BLUE
            cyan = "#ACE0D4",      -- PASTEL_SKYE
            purple = "#D0BBF0",    -- PASTEL_PURPLE
            orange = "#F7A182",    -- PASTEL_ORANGE
            yellow = "#F5D098",    -- PASTEL_YELLOW
            green = "#CAE0A7",     -- PASTEL_GREEN
            red = "#F57F82",       -- PASTEL_RED
            pink = "#F3C0E5",      -- PASTEL_PINK
            cherry = "#F6CEE5",    -- PASTEL_CHERRY
            lime = "#DBE6AF",      -- PASTEL_LIME
            aqua = "#ADDEB9",      -- PASTEL_AQUA
            snow = "#AFDFE6",      -- PASTEL_SNOW
            comment = "#8a8a8a",   -- Muted gray for comments
            border = "#D0BBF0",    -- PASTEL_PURPLE for borders
            selection = "#2a2a2a", -- Slightly lighter background for selections
        }

        require("notify").setup({
            background_colour = "#000000",
        })

        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                message = {
                    view = "notify",
                    view_error = "notify",
                    view_warn = "notify",
                    view_history = "messages",
                    view_search = "virtualtext",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            notify = {
                enabled = true,
                view = "notify",
                title = {
                    error = "【エラー】",
                    warn = "【警告】",
                    info = "【情報】",
                    debug = "【デバッグ】",
                    trace = "【トレース】",
                },
            },
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
                format = {
                    cmdline = {
                        icon = "∮ ",
                        pattern = "^:",
                        title = "コマンド",
                        lang = "vim",
                        icon_hl_group = "NoiceCmdlineIconCommand",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    search_down = {
                        icon = "🔍 ",
                        pattern = "^/",
                        title = "検索",
                        lang = "regex",
                        icon_hl_group = "NoiceCmdlineIconSearch",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    search_up = {
                        icon = "🔎 ",
                        pattern = "^%?",
                        title = "逆検索",
                        lang = "regex",
                        icon_hl_group = "NoiceCmdlineIconSearch",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    filter = {
                        icon = "⚙️ ",
                        pattern = "^:%s*!",
                        title = "シェル",
                        lang = "bash",
                        icon_hl_group = "NoiceCmdlineIconFilter",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    lua = {
                        icon = "☯ ",
                        pattern = "^:%s*lua%s+",
                        title = "Lua",
                        lang = "lua",
                        icon_hl_group = "NoiceCmdlineIconLua",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    help = {
                        icon = "ℹ️ ",
                        pattern = "^:%s*he?l?p?%s+",
                        title = "ヘルプ",
                        icon_hl_group = "NoiceCmdlineIconHelp",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    input = {
                        icon = "⌨️ ",
                        pattern = "^:%s*e?d?i?t?%s+",
                        title = "入力",
                        icon_hl_group = "NoiceCmdlineIconInput",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                },
            },
            popupmenu = {
                enabled = true,
                backend = "nui",
                kind_icons = {
                    Class = "クラス",
                    Color = "カラー",
                    Constant = "定数",
                    Constructor = "コンストラクタ",
                    Enum = "列挙型",
                    EnumMember = "列挙メンバー",
                    Field = "フィールド",
                    File = "ファイル",
                    Folder = "フォルダ",
                    Function = "関数",
                    Interface = "インターフェース",
                    Keyword = "キーワード",
                    Method = "メソッド",
                    Module = "モジュール",
                    Property = "プロパティ",
                    Snippet = "スニペット",
                    Struct = "構造体",
                    Text = "テキスト",
                    Unit = "単位",
                    Value = "値",
                    Variable = "変数",
                },
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                    },
                    opts = { title = "システム" },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                    },
                    opts = { title = "検索結果" },
                },
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = -3,
                        col = "50%",
                    },
                    size = {
                        width = "40%",
                        height = "auto",
                    },
                    border = {
                        style = "rounded",
                        text = {
                            top = " 命令モード ",
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "NoiceCmdlinePopup",
                            FloatBorder = "NoiceCmdlinePopupBorder",
                            CursorLine = "NoiceCmdlinePopupCursorLine",
                            IncSearch = "NoiceCmdlinePopupIncSearch",
                            Search = "NoiceCmdlinePopupSearch",
                        },
                    },
                    filter_options = {},
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = -3,
                        col = "50%",
                    },
                    size = {
                        width = "40%",
                        height = "auto",
                        max_height = 20,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                        text = {
                            top = " 選択 ",
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "NoicePopupmenu",
                            FloatBorder = "NoicePopupmenuBorder",
                            CursorLine = "NoicePopupmenuSelected",
                        },
                    },
                },
            },
        })

        -- Apply pastel color highlighting
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = colors.border })
        vim.api.nvim_set_hl(0, "NoiceCmdlineTitle", { fg = colors.purple, bold = true })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconCommand", { fg = colors.cyan })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconLua", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconHelp", { fg = colors.green })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconInput", { fg = colors.pink })
        vim.api.nvim_set_hl(0, "NoicePopupmenu", { bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = colors.border })
        vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { bg = colors.selection })

        vim.notify = require("notify")
        local original_notify = vim.notify
        vim.notify = function(msg, level, opts)
            local translations = {
                ["saved"] = "保存完了",
                ["yanked"] = "ヤンク完了",
                ["deleted"] = "削除完了",
                ["search hit BOTTOM"] = "検索：下端到達",
                ["search hit TOP"] = "検索：上端到達",
            }

            for eng, jpn in pairs(translations) do
                if msg:match(eng) then
                    msg = msg:gsub(eng, jpn)
                end
            end

            msg = "【ハッカー】" .. msg

            return original_notify(msg, level, opts)
        end
    end
}
