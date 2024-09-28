return {
  "romgrk/barbar.nvim",
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    animation = true,
    auto_hide = false,
    tabpages = false,
    clickable = true,
    -- exclude_ft = {'javascript'},
    -- exclude_name = {'package.json'},
    focus_on_close = 'left',
    -- hide = {extensions = true, inactive = true},
    -- highlight_alternate = false,
    -- highlight_inactive_file_icons = false,
    highlight_visible = true,
    icons = {
      -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
      buffer_index = false,
      button = '󰅙',
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = '' },
        [vim.diagnostic.severity.WARN] = { enabled = true, icon = '' },
        [vim.diagnostic.severity.INFO] = { enabled = true, icon = '' },
        [vim.diagnostic.severity.HINT] = { enabled = true, icon = '' },
      },
      gitsigns = {
        added = {enabled = false, icon = '󰐗'},
        changed = {enabled = false, icon = '󰆗'},
        deleted = {enabled = false, icon = '󰅙'},
      },
      filetype = {
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,
        enabled = true,
      },
      separator_at_end = false,

      modified = { button = '' },
      pinned = { button = '', filename = true },
      preset = 'default',

      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- Supports all the base icon options, plus `modified` and `pinned`.
      -- alternate = {filetype = {enabled = false}},
      -- current = {buffer_index = true},
      -- visible = {modified = {buffer_number = false}},
      separator = {left = '  ', right = '  '},
      inactive = {button = '', separator = {left = ' ', right = ' '}},
      --         -- section_separators = { left = '', right = ''},
    },

    maximum_padding = 1,
    minimum_padding = 1,

    -- Set the filetypes which barbar will offset itself for
    sidebar_filetypes = {
      --   -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
      --   NvimTree = true,
      --   -- Or, specify the text used for the offset:
      --   undotree = {
      --     text = 'undotree',
      --     align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
      --   },
      --   -- Or, specify the event which the sidebar executes when leaving:
      --   ['neo-tree'] = {event = 'BufWipeout'},
      --   -- Or, specify all three
      Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
    },
    no_name_title = "blank",
  }
}
