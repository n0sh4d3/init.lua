return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 32 },
        renderer = { highlight_git = true, icons = { show = { file = true, folder = true, git = true } } },
        filters = { dotfiles = false },
      })
    end,
  },
}
