return {
    -- lazy.nvim
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        -- Get catppuccin colors for consistency
        local catppuccin_colors = require("catppuccin.palettes").get_palette() -- This will get the active flavor
        local colors = {
            bg = catppuccin_colors.base,
            fg = catppuccin_colors.text,
            blue = catppuccin_colors.blue,
            cyan = catppuccin_colors.teal,
            purple = catppuccin_colors.mauve,
            orange = catppuccin_colors.peach,
            yellow = catppuccin_colors.yellow,
            green = catppuccin_colors.green,
            red = catppuccin_colors.red,
            comment = catppuccin_colors.overlay0,
            border = catppuccin_colors.surface0,
            selection = catppuccin_colors.surface1,
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
            -- Presets to customize style
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            -- Customize searches to use floating windows (like cmdline_popup)
            cmdline = {
                enabled = true,
                view = "cmdline_popup", -- Floating window for cmdline
                format = {
                    cmdline = {
                        icon = "コマンド ",
                        pattern = "^:",
                        title = "コマンド",
                        lang = "vim",
                        icon_hl_group = "NoiceCmdlineIconCommand",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    search_down = {
                        icon = "検索 ",
                        pattern = "^/",
                        title = "検索",
                        lang = "regex",
                        icon_hl_group = "NoiceCmdlineIconSearch",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    search_up = {
                        icon = "逆検索 ",
                        pattern = "^%?",
                        title = "逆検索",
                        lang = "regex",
                        icon_hl_group = "NoiceCmdlineIconSearch",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    filter = {
                        icon = "フィルタ ",
                        pattern = "^:%s*!",
                        title = "シェル",
                        lang = "bash",
                        icon_hl_group = "NoiceCmdlineIconFilter",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    lua = {
                        icon = "Lua ",
                        pattern = "^:%s*lua%s+",
                        title = "Lua",
                        lang = "lua",
                        icon_hl_group = "NoiceCmdlineIconLua",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    help = {
                        icon = "ヘルプ ",
                        pattern = "^:%s*he?l?p?%s+",
                        title = "ヘルプ",
                        icon_hl_group = "NoiceCmdlineIconHelp",
                        title_hl_group = "NoiceCmdlineTitle",
                    },
                    input = {
                        icon = "入力 ",
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
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                    text = {
                        top = " 完了候補 ",
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
            views = {
                -- Make cmdline_popup and search use similar floating windows
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
                        },
                    },
                },
                -- Adjust search views to have a floating look similar to cmdline
                search_down = {
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
                        text = {
                            top = " 検索結果 ",
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "NoiceSearchResult",
                            FloatBorder = "NoiceSearchResultBorder",
                            CursorLine = "NoiceSearchResultSelected",
                        },
                    },
                },
                search_up = {
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
                        text = {
                            top = " 逆検索結果 ",
                            top_align = "center",
                        },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "NoiceSearchResult",
                            FloatBorder = "NoiceSearchResultBorder",
                            CursorLine = "NoiceSearchResultSelected",
                        },
                    },
                },
            },
        })

        -- Define highlight groups to match catppuccin
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
        vim.api.nvim_set_hl(0, "NoiceSearchResult", { bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoiceSearchResultBorder", { fg = colors.orange, bg = colors.bg })
        vim.api.nvim_set_hl(0, "NoiceSearchResultSelected", { bg = colors.selection })

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
