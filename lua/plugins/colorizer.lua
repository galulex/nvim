return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = { "css", "javascript", "html", "lua", "typescript", "slim", "erb" },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = false,
      css_fn = true,
      mode = "background",
      tailwind = "lsp",
    },
  },
}
