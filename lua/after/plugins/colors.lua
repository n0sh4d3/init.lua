return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true, -- enables transparency
      style = "storm",    -- you can also choose "night", "day", "moon"
      styles = {
        sidebars = "transparent",
      },
    })

    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
