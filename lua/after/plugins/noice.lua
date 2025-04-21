return {
    -- lazy.nvim
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        -- Get tokyonight-night colors for consistency
        local tokyonight_colors = require("tokyonight.colors").setup({ style = "night" })
        local colors = {
            bg = tokyonight_colors.bg_dark,
            fg = tokyonight_colors.fg,
            blue = tokyonight_colors.blue,
            cyan = tokyonight_colors.cyan,
            purple = tokyonight_colors.purple,
            orange = tokyonight_colors.orange,
            yellow = tokyonight_colors.yellow,
            green = tokyonight_colors.green,
            red = tokyonight_colors.red,
            comment = tokyonight_colors.comment,
            border = tokyonight_colors.border,
            selection = tokyonight_colors.selection,
        }

        require("noice").setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
                -- Japanese translations for LSP messages
                message = {
                    -- Override LSP message format
                    view = "notify",
                    view_error = "notify",
                    view_warn = "notify",
                    view_history = "messages",
                    view_search = "virtualtext",
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            -- Japanese translations and hacker theme
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            notify = {
                -- Customize notifications
                enabled = true,
                view = "notify",
                -- Japanese titles and hacker style
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
                view = "cmdline_popup", -- Changed to popup for enhanced styling
                format = {
                    -- Enhanced command line prompts with icons and styling
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
                    -- Japanese descriptions for completion items
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
            -- Custom hacker-style Japanese UI elements
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
            -- Enhanced styling for command mode
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

        -- Define highlight groups to match tokyonight-night
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = colors.blue, bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoiceCmdlineTitle", { fg = colors.purple, bold = true })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconCommand", { fg = colors.cyan })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconLua", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconHelp", { fg = colors.green })
        vim.api.nvim_set_hl(0, "NoiceCmdlineIconInput", { fg = colors.red })
        vim.api.nvim_set_hl(0, "NoicePopupmenu", { bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoicePopupmenuBorder", { fg = colors.purple, bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { bg = colors.selection })

        -- Additional Japanese status messages
        vim.notify = require("notify")
        local original_notify = vim.notify
        vim.notify = function(msg, level, opts)
            -- Translate common messages to Japanese
            local translations = {
                ["saved"] = "保存完了",
                ["yanked"] = "ヤンク完了",
                ["deleted"] = "削除完了",
                ["search hit BOTTOM"] = "検索：下端到達",
                ["search hit TOP"] = "検索：上端到達",
            }

            -- Look for common English phrases and translate them
            for eng, jpn in pairs(translations) do
                if msg:match(eng) then
                    msg = msg:gsub(eng, jpn)
                end
            end

            -- Add hacker prefix to messages
            msg = "【ハッカー】" .. msg

            return original_notify(msg, level, opts)
        end
    end
}
