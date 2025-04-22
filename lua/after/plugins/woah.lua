return {
    "goolord/alpha-nvim",
    config = function()
        local status_ok, alpha = pcall(require, "alpha")
        if not status_ok then
            return
        end

        local dashboard = require("alpha.themes.dashboard")

        -- ASCII Header
        dashboard.section.header.val = {
            [[]],
            [[]],
            [[███╗   ██╗ ██████╗         ███████╗██╗  ██╗██╗  ██╗██████╗ ██████╗ ]],
            [[████╗  ██║██╔═████╗        ██╔════╝██║  ██║██║  ██║██╔══██╗╚════██╗]],
            [[██╔██╗ ██║██║██╔██║        ███████╗███████║███████║██║  ██║ █████╔╝]],
            [[██║╚██╗██║████╔╝██║        ╚════██║██╔══██║╚════██║██║  ██║ ╚═══██╗]],
            [[██║ ╚████║╚██████╔╝███████╗███████║██║  ██║     ██║██████╔╝██████╔╝]],
            [[╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝     ╚═╝╚═════╝ ╚═════╝ ]],
            [[]],
            [[                  私の概念実証はあなたの事後分析です。]],
        }

        -- Buttons (Japanese labels, Nerd Font icons only)
        dashboard.section.buttons.val = {
            dashboard.button("f", "  ファイルを探す", ":Telescope find_files <CR>"),
            dashboard.button("e", "  新しいファイル", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "  最近使ったファイル", ":Telescope oldfiles <CR>"),
            dashboard.button("t", "  テキスト検索", ":Telescope live_grep <CR>"),
            dashboard.button("q", "  終了する", ":qa<CR>"),
        }

        -- Footer (Japanese motivational quote)
        dashboard.section.footer.val = "\n私はペンテストをしない。テストを終わらせる。"

        -- Highlights
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"
        dashboard.section.footer.opts.hl = "Type"

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)
    end,
    lazy = false,
}
