return {
  -- Chafa image viewer as ASCII art
  {
    "Frederick888/chafa.nvim",
    branch = "new-chafa", -- Use the branch with fixes
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim" -- for ANSI colors
    },
    config = function()
      require("chafa").setup({
        render = {
          -- min_padding = 5,
          show_label = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      })
    end
  },
}
