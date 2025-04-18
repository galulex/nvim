return {
  "mawkler/modicator.nvim",
  dependencies = {
    "olimorris/onedarkpro.nvim"
  },
  config = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
    require('modicator').setup({
      -- Warn if any required option is missing. May emit false positives if some
      -- other plugin modifies them, which in that case you can just ignore
      show_warnings = true,
      highlights = {
        -- Default options for bold/italic
        defaults = {
          bold = true,
          italic = true,
        },
      },
      integration = {
        lualine = {
          enabled = false,
          -- Letter of lualine section to use (if `nil`, gets detected automatically)
          mode_section = nil,
          -- Whether to use lualine's mode highlight's foreground or background
          highlight = 'fg',
        },
      },
    })
  end,
}
