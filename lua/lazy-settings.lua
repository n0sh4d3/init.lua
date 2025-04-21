require("lazy").setup({
    spec = {
        {
            import = "after.plugins",
        },
    },
    change_detection = {
        enable = false,
        notify = true,
    },
    install = {
        missing = true,
        colorscheme = { "tokyonight" } -- Changed to a more cyber theme name
    },
    ui = {
        size = { width = 0.75, height = 0.75 },
        wrap = true,
        backdrop = 80,
        border = "rounded",
        title = " 影無し - n0_sh4d3 ",
        title_pos = "center",
        icons = {
            cmd = "⌘",
            config = "零", -- "Zero" kanji
            event = "イ",
            ft = "書", -- "Document" kanji
            init = "起", -- "Start" kanji
            keys = "鍵", -- "Key" kanji
            plugin = "電", -- "Electric" kanji
            runtime = "実", -- "Reality" kanji
            source = "源", -- "Source" kanji
            start = "動", -- "Move" kanji
            task = "務", -- "Task" kanji
        },

    },
    performance = {
        cache = { enabled = true, },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "bugreport",
                "compiler",
                "ftplugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "matchit",
                "optwin",
                "rplugin",
                "rrhelper",
                "spellfile_plugin",
                "synmenu",
                "syntax",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
            },
        },
    },
})
