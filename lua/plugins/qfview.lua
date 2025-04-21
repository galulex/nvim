return {
  "yorickpeterse/nvim-pqf",
  event = "UIEnter",
  config = function ()
    require('pqf').setup({
      signs = {
        error = { text = '', hl = 'DiagnosticSignError' },
        warning = { text = '', hl = 'DiagnosticSignWarn' },
        info = { text = '', hl = 'DiagnosticSignInfo' },
        hint = { text = '󱠂', hl = 'DiagnosticSignHint' },
      },

      show_multiple_lines = false,
      max_filename_length = 120,

      -- Prefix to use for truncated filenames.
      filename_truncate_prefix = '󰛁',
    })
  end,
}
