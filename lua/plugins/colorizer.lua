return {
  "lewis6991/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup(
      { "css", "javascript", "lua", "vim", "toml", "svelte", "typescript", "html" },
      { mode = 'background', css = true, lowercase = true }
    )
  end,
}
