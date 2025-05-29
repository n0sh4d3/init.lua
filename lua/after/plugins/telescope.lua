return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.have_nerd_font,
      },
    },
    config = function()
      local japanese_titles = {

        find_files = "ファイル検索 【サイバー探索】",
        git_files = "Git ファイル 【リポジトリ】",
        buffers = "バッファ 【メモリ状態】",
        oldfiles = "履歴 【アク[48;35;130;1680;2860tセス記録】",
        live_grep = "ライブ検索 【リアルタイム解析】",
        grep_string = "文字列検索 【ハッキング】",
        help_tags = "ヘルプ 【支援データベース】",
        current_buffer_fuzzy_find = "バッファ内検索 【局所スキャン】",
        lsp_references = "参照先 【コード接続】",
        lsp_document_symbols = "ドキュメント記号 【構造解析】",
        diagnostics = "診断 【エラー解析】",
        commands = "コマンド 【システム命令】",
        man_pages = "マニュアル 【説明書】",
        marks = "マーク 【位置標識】",
        colorscheme = "カラースキーム 【視覚設定】",
        quickfix = "クイックフィックス 【修正リスト】",
        loclist = "位置リスト 【場所一覧】",
        jumplist = "ジャンプリスト 【移動履歴】",
        vim_options = "Vim設定 【構成オプション】",
        registers = "レジスタ 【クリップボード】",
        autocommands = "自動コマンド 【トリガー設定】",
        spell_suggest = "スペル候補 【修正提案】",
        keymaps = "キー設定 【操作割当】",
        filetypes = "ファイルタイプ 【種別設定】",
        highlights = "ハイライト 【色彩設定】",
        git_commits = "Gitコミット 【変更履歴】",
        git_bcommits = "バッファコミット 【ファイル履歴】",
        git_branches = "Gitブランチ 【分岐一覧】",
        git_status = "Git状態 【変更状況】",
        git_stash = "Gitスタッシュ 【一時保存】",


        results = "検索結果",


        select = "選択",
        paste = "貼り付け",
        delete = "削除",
        rename = "名前変更",
        create = "作成",
        update = "更新",
        search = "検索",
        filter = "フィルター",
        preview = "プレビュー",
      }


      require("telescope").setup({
        defaults = {
          prompt_prefix = " サイバー  ",
          selection_caret = "❯❯ ",
          entry_prefix = "  ",
          multi_icon = "⦿ ",


          results_title = japanese_titles.results,


          layout_strategy = "horizontal",
          layout_config = {
            width = 0.82,
            height = 0.92,
            preview_cutoff = 120,
            prompt_position = "top",
            horizontal = {
              preview_width = 0.5,
            },
            vertical = {
              preview_height = 0.65,
            },
          },


          borderchars = { "━", "┃", "━", "┃", "╭", "╮", "╯", "╰" },

          sorting_strategy = "ascending",
          selection_strategy = "reset",
          scroll_strategy = "cycle",
          color_devicons = true,
          winblend = 0,

          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },


        pickers = {
          find_files = {
            prompt_title = japanese_titles.find_files,
            results_title = japanese_titles.results,
          },
          git_files = {
            prompt_title = japanese_titles.git_files,
            results_title = japanese_titles.results,
          },
          grep_string = {
            prompt_title = japanese_titles.grep_string,
            results_title = japanese_titles.results,
          },
          live_grep = {
            prompt_title = japanese_titles.live_grep,
            results_title = japanese_titles.results,
          },
          buffers = {
            prompt_title = japanese_titles.buffers,
            results_title = japanese_titles.results,
          },
          help_tags = {
            prompt_title = japanese_titles.help_tags,
            results_title = japanese_titles.results,
          },
          oldfiles = {
            prompt_title = japanese_titles.oldfiles,
            results_title = japanese_titles.results,
          },
          current_buffer_fuzzy_find = {
            prompt_title = japanese_titles.current_buffer_fuzzy_find,
            results_title = japanese_titles.results,
          },
          lsp_references = {
            prompt_title = japanese_titles.lsp_references,
            results_title = japanese_titles.results,
          },
          diagnostics = {
            prompt_title = japanese_titles.diagnostics,
            results_title = japanese_titles.results,
          },
          commands = {
            prompt_title = japanese_titles.commands,
            results_title = japanese_titles.results,
          },
        },

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              prompt_title = "【選択メニュー】",
              results_title = "選択オプション",
              layout_config = {
                width = 0.6,
                height = 0.6,
              },
              borderchars = { "━", "┃", "━", "┃", "╭", "╮", "╯", "╰" },
            }),
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })


      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")


      local builtin = require("telescope.builtin")


      local original_builtin = {}
      for k, v in pairs(builtin) do
        original_builtin[k] = v
        builtin[k] = function(opts)
          opts = opts or {}

          if japanese_titles[k] and not opts.prompt_title then
            opts.prompt_title = japanese_titles[k]
          end
          if not opts.results_title then
            opts.results_title = japanese_titles.results
          end
          return original_builtin[k](opts)
        end
      end


      vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "📁 【探索】ファイル検索" })

      vim.keymap.set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
      end, { desc = "🛠️ 【修正】コードアクション" })

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 0,
          previewer = false,
        }))
      end, { desc = "🔍 【バッファ内】検索" })

      vim.keymap.set("n", "<leader>l", function()
        builtin.live_grep({
          grep_open_files = true,
        })
      end, { desc = "🕵️ 【全文】ライブグレップ" })

      vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "📜 【履歴】最近開いたファイル" })

      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "📋 【メモリ】バッファリスト" })


      local has_telescope = pcall(require, "telescope")
      if has_telescope then
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local sorters = require("telescope.sorters")
        local themes = require("telescope.themes")


        local japanese_help = function(opts)
          opts = opts or {}

          local help_items = {
            { key = "j/k", desc = "選択を上下に移動" },
            { key = "<Down>/<Up>", desc = "選択を上下に移動" },
            { key = "<CR>", desc = "選択項目を開く" },
            { key = "<C-x>", desc = "水平分割で開く" },
            { key = "<C-v>", desc = "垂直分割で開く" },
            { key = "<C-t>", desc = "新しいタブで開く" },
            { key = "<C-u>/<C-d>", desc = "プレビュー画面をスクロール" },
            { key = "<C-n>/<C-p>", desc = "履歴を移動" },
            { key = "<Tab>", desc = "複数選択を追加" },
            { key = "<C-q>", desc = "選択をQuickfixに送信" },
            { key = "<Esc>", desc = "検索を終了" },
            { key = "<C-c>", desc = "検索を終了" },
            { key = "?", desc = "キーマップヘルプを表示" },
          }

          pickers.new(opts, {
            prompt_title = "🔰 テレスコープ【ヘルプ】",
            finder = finders.new_table {
              results = help_items,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.key .. " ➜ " .. entry.desc,
                  ordinal = entry.key .. " " .. entry.desc,
                }
              end,
            },
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
              end)
              return true
            end,
          }):find()
        end

        builtin.japanese_help = japanese_help


        vim.keymap.set("n", "<leader>fh", builtin.japanese_help, { desc = "🔰 【ヘルプ】テレスコープ" })
      end

      vim.defer_fn(function()
        vim.notify("テレスコープ：日本語サイバーモード有効化", vim.log.levels.INFO, {
          title = "【システム】",
        })
      end, 800)
    end,
  },
}
