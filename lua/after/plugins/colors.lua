return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true, -- enables transparency
      style = "storm",    -- you can also choose "night", "day", "moon"
    })

    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
