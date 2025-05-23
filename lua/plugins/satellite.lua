return {
  "lewis6991/satellite.nvim",
  enabled = true,
  config = function()
    require('satellite').setup {
      current_only = false,
      winblend = 40,
      zindex = 100,
      excluded_filetypes = {
        "cmp_docs",
        "cmp_menu",
        "noice",
        "prompt",
        "TelescopePrompt",
      },
      width = 2,
      handlers = {
        cursor = {
          enable = false,
          overlap = true,
          priority = 100,
          -- Supports any number of symbols
          symbols = { '⎺', '⎻', '⎼', '⎽' }
          -- symbols = { '⎻', '⎼' }
          -- Highlights:
          -- - SatelliteCursor (default links to NonText
        },
        search = {
          enable = true,
          -- Highlights:
          -- - SatelliteSearch (default links to Search)
          -- - SatelliteSearchCurrent (default links to SearchCurrent)
          symbols = { '-', '=', '≡', '󰕱', '󰉡', '󰉡' },
        },
        diagnostic = {
          enable = true,
          signs = {'-', '=', '≡'},
          min_severity = vim.diagnostic.severity.HINT,
          -- Highlights:
          -- - SatelliteDiagnosticError (default links to DiagnosticError)
          -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
          -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
          -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
        },
        gitsigns = {
          enable = false,
          signs = { -- can only be a single character (multibyte is okay)
            add = "│",
            change = "│",
            delete = "-",
          },
          -- Highlights:
          -- SatelliteGitSignsAdd (default links to GitSignsAdd)
          -- SatelliteGitSignsChange (default links to GitSignsChange)
          -- SatelliteGitSignsDelete (default links to GitSignsDelete)
        },
        marks = {
          enable = false,
          show_builtins = false, -- shows the builtin marks like [ ] < >
          key = 'm'
          -- Highlights:
          -- SatelliteMark (default links to Normal)
        },
        quickfix = {
          enable = true,
          overlap = true,
          priority = 100,
          signs = { '-', '=', '≡' },
          -- Highlights:
          -- SatelliteQuickfix (default links to WarningMsg)
        }
      },
    }
  end,
}
