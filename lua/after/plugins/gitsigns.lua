return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "▎" }, -- 追加
                change = { text = "▎" }, -- 変更
                delete = { text = "" }, -- 削除
                topdelete = { text = "" }, -- トップ削除
                changedelete = { text = "▎" }, -- 変更削除
                untracked = { text = "▎" }, -- 未追跡
            },
            signs_staged = {
                add = { text = "▎" }, -- 追加
                change = { text = "▎" }, -- 変更
                delete = { text = "" }, -- 削除
                topdelete = { text = "" }, -- トップ削除
                changedelete = { text = "▎" }, -- 変更削除
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- Key bindings with Japanese descriptions
                map("n", "]h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "次のハンク") -- Next Hunk
                map("n", "[h", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "前のハンク") -- Previous Hunk
                map("n", "]H", function() gs.nav_hunk("last") end, "最後のハンク") -- Last Hunk
                map("n", "[H", function() gs.nav_hunk("first") end, "最初のハンク") -- First Hunk
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "ハンクをステージ") -- Stage Hunk
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "ハンクをリセット") -- Reset Hunk
                map("n", "<leader>ghS", gs.stage_buffer, "バッファをステージ") -- Stage Buffer
                map("n", "<leader>ghu", gs.undo_stage_hunk, "ステージを元に戻す") -- Undo Stage Hunk
                map("n", "<leader>ghR", gs.reset_buffer, "バッファをリセット") -- Reset Buffer
                map("n", "<leader>ghp", gs.preview_hunk_inline, "ハンクをプレビュー") -- Preview Hunk Inline
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "ラインの責任者") -- Blame Line
                map("n", "<leader>ghB", function() gs.blame() end, "バッファの責任者") -- Blame Buffer
                map("n", "<leader>ghd", gs.diffthis, "この差分を見る") -- Diff This
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "この差分 ~ を見る") -- Diff This ~
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "ハンクを選択") -- Select Hunk
            end,
        },
    }
}
