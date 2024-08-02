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
        colorscheme = { "catppuccin" }
    },


    ui = {
        size = { width = 0.75, height = 0.75 },
        wrap = true,
        backdrop = 80,
        border = "rounded",
        title = " ＭＡＳＴＥＲＭＩＮＤ",
        title_pos = "left",
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
