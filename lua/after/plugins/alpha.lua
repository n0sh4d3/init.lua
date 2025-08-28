return {
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
}
