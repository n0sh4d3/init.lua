return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn
              .executable("make") == 1
        end
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require("telescope")
      local actions_layout = require("telescope.actions.layout")

      -- use your floating panel bg (same as cmp/NormalFloat if set)
      local function hl(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) or {} end
      local normal    = hl("Normal")
      local nf_bg     = hl("NormalFloat").bg or tonumber("0x1f2335")
      local panel_hex = ("#%06x"):format(nf_bg)

      -- borderless + solid panel bg
      for _, g in ipairs({
        "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
        "TelescopeTitle", "TelescopePromptTitle", "TelescopeResultsTitle", "TelescopePreviewTitle",
      }) do
        vim.api.nvim_set_hl(0, g, { fg = "NONE", bg = "NONE" })
      end
      vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = normal.fg, bg = panel_hex })
      vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = normal.fg, bg = panel_hex })
      vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { fg = normal.fg, bg = panel_hex })
      vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { fg = normal.fg, bg = panel_hex })
      vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "Visual" })
      vim.api.nvim_set_hl(0, "TelescopeMatching", { link = "IncSearch" })
      vim.api.nvim_set_hl(0, "TelescopePreviewLine", { link = "Visual" })

      telescope.setup({
        defaults = {
          prompt_prefix        = "› ",
          selection_caret      = "› ",
          entry_prefix         = "  ",

          border               = false,
          borderchars          = { "", "", "", "", "", "", "", "" },
          results_title        = false,

          -- COMPACT + ALWAYS PREVIEW
          sorting_strategy     = "ascending",
          layout_strategy      = "horizontal",
          layout_config        = {
            prompt_position = "top",
            width           = 0.90, -- smaller overall width
            height          = 0.80, -- smaller height
            preview_width   = 0.60,
            preview_cutoff  = 1,    -- 👈 never auto-hide preview
          },
          winblend             = 0,
          color_devicons       = true,
          scroll_strategy      = "cycle",

          vimgrep_arguments    = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case",
            "--hidden", "--glob=!.git/*", "--respect-gitignore",
          },
          file_ignore_patterns = {
            "%.git/", "node_modules/", "%.DS_Store", "__pycache__/", "%.tox/", "%.venv/", "venv/", "env/", "ENV/",
            "dist/", "build/", "target/", "vendor/", "%.lock", "%.tmp", "%.log", "%.sqlite", "%.db", "%.cache/",
            "%.idea/", "%.vscode/", "%.swp", "%.swo", "~$",
          },

          mappings             = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-n>"] = "cycle_history_next",
              ["<C-p>"] = "cycle_history_prev",
              ["<M-p>"] = actions_layout.toggle_preview, -- 👈 quick toggle
              ["<Esc>"] = "close",
            },
            n = {
              ["q"] = "close",
              ["<M-p>"] = actions_layout.toggle_preview,
            },
          },
        },

        -- preview ON by default for primary pickers
        pickers = {
          find_files                = {
            prompt_title = false,
            results_title = false,
            preview_title = false,
            previewer = true,
            find_command = vim.fn.executable("fd") == 1 and {
              "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git",
              "--ignore-file", ".gitignore", "--ignore-file", ".ignore",
            } or nil,
          },
          git_files                 = { prompt_title = false, results_title = false, preview_title = false, show_untracked = true, previewer = true },
          buffers                   = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
          oldfiles                  = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
          live_grep                 = {
            prompt_title = false,
            results_title = false,
            preview_title = false,
            previewer = true,
            additional_args = { "--hidden", "--respect-gitignore" },
          },
          grep_string               = {
            prompt_title = false,
            results_title = false,
            preview_title = false,
            previewer = true,
            additional_args = { "--hidden", "--respect-gitignore" },
          },
          current_buffer_fuzzy_find = { prompt_title = false, results_title = false, preview_title = false, previewer = false },
          lsp_references            = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
          lsp_document_symbols      = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
          diagnostics               = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
          help_tags                 = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
          commands                  = { prompt_title = false, results_title = false, preview_title = false, previewer = true },
        },

        extensions = {
          fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
          ["ui-select"] = {
            border = false,
            borderchars = { "", "", "", "", "", "", "", "" },
            winblend = 0,
            previewer = false,
            prompt_title = false,
            results_title = false,
            preview_title = false,
            layout_strategy = "cursor",
            sorting_strategy = "ascending",
            layout_config = {
              width = 50,
              height = 15,
            },
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")

      -- wrapper: keep titles off everywhere
      local builtin, original = require("telescope.builtin"), {}
      for k, v in pairs(builtin) do
        original[k] = v
        builtin[k] = function(opts)
          opts = opts or {}
          if opts.prompt_title == nil then opts.prompt_title = false end
          if opts.results_title == nil then opts.results_title = false end
          if opts.preview_title == nil then opts.preview_title = false end
          return original[k](opts)
        end
      end

      -- keys
      vim.keymap.set("n", "<leader>pf", function()
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then builtin.git_files() else builtin.find_files() end
      end, { desc = "Find Files / Git Files" })
      vim.keymap.set("n", "<leader>pF", builtin.find_files, { desc = "Find All Files" })
      vim.keymap.set("n", "<leader>/", function() builtin.current_buffer_fuzzy_find({ previewer = false }) end,
        { desc = "Fuzzy Find (Buffer)" })
      vim.keymap.set("n", "<leader>l", function()
        builtin.live_grep({ grep_open_files = true, additional_args = { "--hidden", "--respect-gitignore" } })
      end, { desc = "Live Grep (Open Files)" })
      vim.keymap.set("n", "<leader>L", function()
        builtin.live_grep({ additional_args = { "--hidden", "--respect-gitignore" } })
      end, { desc = "Live Grep (Project)" })
      vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "History" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
    end,
  },
}
