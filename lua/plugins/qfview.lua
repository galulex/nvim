return {
  "yorickpeterse/nvim-pqf",
  event = "UIEnter",
  config = function ()
    require('pqf').setup({
      signs = {
        error = { text = 'E', hl = 'DiagnosticSignError' },
        warning = { text = 'W', hl = 'DiagnosticSignWarn' },
        info = { text = 'I', hl = 'DiagnosticSignInfo' },
        hint = { text = 'H', hl = 'DiagnosticSignHint' },
      },

      show_multiple_lines = false,
      max_filename_length = 50,

      -- Prefix to use for truncated filenames.
      filename_truncate_prefix = '󰛁 ',
    })
  end,
}
