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
      local info_titles = {
        find_files = "Find Files",
        git_files = "Git Files",
        buffers = "Buffers",
        oldfiles = "History",
        live_grep = "Live Grep",
        grep_string = "Grep String",
        help_tags = "Help",
        current_buffer_fuzzy_find = "Fuzzy Find (Buffer)",
        lsp_references = "References",
        lsp_document_symbols = "Document Symbols",
        diagnostics = "Diagnostics",
        commands = "Commands",
        man_pages = "Man Pages",
        marks = "Marks",
        colorscheme = "Colorscheme",
        quickfix = "Quickfix",
        loclist = "Location List",
        jumplist = "Jump List",
        vim_options = "Vim Options",
        registers = "Registers",
        autocommands = "Autocommands",
        spell_suggest = "Spell Suggest",
        keymaps = "Keymaps",
        filetypes = "Filetypes",
        highlights = "Highlights",
        git_commits = "Git Commits",
        git_bcommits = "Buffer Commits",
        git_branches = "Git Branches",
        git_status = "Git Status",
        git_stash = "Git Stash",
        results = "Results",
        select = "Select",
        paste = "Paste",
        delete = "Delete",
        rename = "Rename",
        create = "Create",
        update = "Update",
        search = "Search",
        filter = "Filter",
        preview = "Preview",
      }

      require("telescope").setup({
        defaults = {
          prompt_prefix = "> ",
          selection_caret = "> ",
          entry_prefix = "  ",
          multi_icon = "+ ",

          results_title = info_titles.results,

          -- Key additions for gitignore support
          file_ignore_patterns = {
            -- General patterns
            "%.git/",
            "node_modules/",
            "%.DS_Store",
            "%.pyc",
            "__pycache__/",
            "%.pyo",
            "%.pyd",
            "%.so",
            "%.dylib",
            "%.egg%-info/",
            "%.egg",
            "dist/",
            "build/",
            "%.coverage",
            "htmlcov/",
            "%.pytest_cache/",
            "%.tox/",
            "%.venv/",
            "venv/",
            "env/",
            "ENV/",
            -- Go patterns
            "%.exe",
            "%.exe~",
            "%.dll",
            "%.so",
            "%.dylib",
            "%.test",
            "%.out",
            "go%.work",
            "vendor/",
            -- Rust patterns
            "target/",
            "Cargo%.lock",
            "%.rlib",
            "%.rmeta",
            "%.crate",
            -- Additional common patterns
            "%.tmp",
            "%.log",
            "%.sqlite",
            "%.db",
            "%.cache/",
            "%.idea/",
            "%.vscode/",
            "%.swp",
            "%.swo",
            "~$",
          },

          -- Enable vimgrep_arguments with proper gitignore support
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",            -- Search hidden files
            "--glob=!.git/*",      -- But exclude .git directory
            "--respect-gitignore", -- This is the key option
          },

          layout_strategy = "horizontal",
          layout_config = {
            width = 0.85,
            height = 0.85,
            preview_cutoff = 40,
            prompt_position = "top",
            horizontal = {
              preview_width = 0.55,
              mirror = false,
            },
            vertical = {
              preview_height = 0.5,
              mirror = false,
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
              ["<C-n>"] = "cycle_history_next",
              ["<C-p>"] = "cycle_history_prev",
            },
            n = {
              ["q"] = "close",
            },
          },
        },

        pickers = {
          find_files = {
            prompt_title = info_titles.find_files,
            results_title = info_titles.results,
            previewer = true,
            -- Use fd if available (better gitignore support)
            find_command = vim.fn.executable("fd") == 1 and {
              "fd",
              "--type", "f",
              "--hidden",
              "--follow",
              "--exclude", ".git",
              "--ignore-file", ".gitignore",
              "--ignore-file", ".ignore",
            } or nil,
          },
          git_files = {
            prompt_title = info_titles.git_files,
            results_title = info_titles.results,
            previewer = true,
            -- git_files automatically respects gitignore
            show_untracked = true,
            recurse_submodules = false,
          },
          grep_string = {
            prompt_title = info_titles.grep_string,
            results_title = info_titles.results,
            previewer = true,
            additional_args = { "--hidden", "--respect-gitignore" },
          },
          live_grep = {
            prompt_title = info_titles.live_grep,
            results_title = info_titles.results,
            previewer = true,
            additional_args = { "--hidden", "--respect-gitignore" },
          },
          buffers = {
            prompt_title = info_titles.buffers,
            results_title = info_titles.results,
            previewer = true,
          },
          help_tags = {
            prompt_title = info_titles.help_tags,
            results_title = info_titles.results,
            previewer = true,
          },
          oldfiles = {
            prompt_title = info_titles.oldfiles,
            results_title = info_titles.results,
            previewer = true,
          },
          current_buffer_fuzzy_find = {
            prompt_title = info_titles.current_buffer_fuzzy_find,
            results_title = info_titles.results,
            previewer = true,
          },
          lsp_references = {
            prompt_title = info_titles.lsp_references,
            results_title = info_titles.results,
            previewer = true,
          },
          diagnostics = {
            prompt_title = info_titles.diagnostics,
            results_title = info_titles.results,
            previewer = true,
          },
          commands = {
            prompt_title = info_titles.commands,
            results_title = info_titles.results,
            previewer = true,
          },
        },

        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              prompt_title = "Select Menu",
              results_title = "Options",
              layout_config = {
                width = 0.65,
                height = 0.6,
              },
              borderchars = { "━", "┃", "━", "┃", "╭", "╮", "╯", "╰" },
              winblend = 15,
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
          if info_titles[k] and not opts.prompt_title then
            opts.prompt_title = info_titles[k]
          end
          if not opts.results_title then
            opts.results_title = info_titles.results
          end
          if opts.previewer == nil then
            opts.previewer = true
          end
          return original_builtin[k](opts)
        end
      end

      -- Keymaps with clean, informational descriptions
      vim.keymap.set("n", "<leader>pf", function()
        local function is_git_repo()
          vim.fn.system("git rev-parse --is-inside-work-tree")
          return vim.v.shell_error == 0
        end
        if is_git_repo() then
          builtin.git_files()
        else
          builtin.find_files()
        end
      end, { desc = "Find Files" })

      vim.keymap.set("n", "<leader>pF", builtin.find_files, { desc = "Find All Files" })
      vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 15,
          previewer = false,
        }))
      end, { desc = "Fuzzy Find (Buffer)" })
      vim.keymap.set("n", "<leader>l", function()
        builtin.live_grep({
          grep_open_files = true,
          additional_args = { "--hidden", "--respect-gitignore" },
        })
      end, { desc = "Live Grep (Open Files)" })
      vim.keymap.set("n", "<leader>L", function()
        builtin.live_grep({
          additional_args = { "--hidden", "--respect-gitignore" },
        })
      end, { desc = "Live Grep (Project)" })
      vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "History" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })

      local has_telescope = pcall(require, "telescope")
      if has_telescope then
        local actions = require("telescope.actions")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local sorters = require("telescope.sorters")

        local info_help = function(opts)
          opts = opts or {}
          local help_items = {
            { key = "j/k",         desc = "Move selection up/down" },
            { key = "<Down>/<Up>", desc = "Move selection up/down" },
            { key = "<CR>",        desc = "Open selected item" },
            { key = "<C-x>",       desc = "Open in horizontal split" },
            { key = "<C-v>",       desc = "Open in vertical split" },
            { key = "<C-t>",       desc = "Open in new tab" },
            { key = "<C-u>/<C-d>", desc = "Scroll preview window" },
            { key = "<C-n>/<C-p>", desc = "Cycle history" },
            { key = "<Tab>",       desc = "Add to multi-select" },
            { key = "<C-q>",       desc = "Send to Quickfix" },
            { key = "<Esc>",       desc = "Close search" },
            { key = "<C-c>",       desc = "Close search" },
            { key = "?",           desc = "Show keymap help" },
          }

          pickers.new(opts, {
            prompt_title = "Telescope Help",
            finder = finders.new_table {
              results = help_items,
              entry_maker = function(entry)
                return {
                  value = entry,
                  display = entry.key .. " -> " .. entry.desc,
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

        builtin.info_help = info_help
        vim.keymap.set("n", "<leader>fh", builtin.info_help, { desc = "Telescope Help" })
      end

      vim.defer_fn(function()
        vim.notify("Telescope: Informational mode enabled + gitignore support", vim.log.levels.INFO, {
          title = "[System]",
        })
      end, 800)
    end,
  },
}
