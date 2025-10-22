local g = vim.g
local o = vim.opt

-- UI
o.guifont = "Menlo:h17"
o.pumblend = 15                         -- Popup menu transparency
o.number = true                         -- Show line numbers
o.relativenumber = true                 -- Relative line numbers
o.cursorline = true                     -- Highlight current line
o.cursorlineopt = "number"              -- Only highlight line number
o.signcolumn = "yes"                    -- Always show sign column
o.termguicolors = true                  -- True color support
o.showmatch = true                      -- Highlight matching brackets
o.list = true                           -- Show whitespace
o.listchars = "trail:•"                 -- Show trailing spaces
o.showtabline = 2                       -- Always show tabline
o.laststatus = 3                        -- Global statusline
o.winblend = 0                          -- Window transparency

-- Editing
o.clipboard = "unnamedplus"             -- Use system clipboard
o.mouse = "a"                           -- Enable mouse
o.mousemodel = "popup"                  -- Right-click shows popup menu
o.autoindent = true                     -- Auto indent
o.expandtab = true                      -- Spaces instead of tabs
o.shiftwidth = 2                        -- Indent width
o.tabstop = 2                           -- Tab width
o.backspace = "indent,eol,start"        -- Intuitive backspacing

-- Search
o.incsearch = true                      -- Incremental search
o.hlsearch = true                       -- Highlight search matches

-- Scrolling
o.scrolloff = 3                         -- Context lines around cursor
o.startofline = false                   -- Keep column when scrolling
o.mousescroll = "ver:1,hor:0"           -- Disable horizontal scroll

-- Commands
o.inccommand = "split"                  -- Live preview for :substitute
o.shortmess = "filmnrxtTI"              -- Disable intro message
o.ttimeoutlen = 0                       -- Key code timeout

-- Files
o.autoread = true                       -- Auto reload changed files
o.undofile = true                       -- Persistent undo
o.backup = false                        -- No backup files
o.writebackup = false                   -- No backup while writing
o.swapfile = false                      -- No swap files
o.updatetime = 100                      -- Faster completion

-- Splits
o.splitright = true                     -- Vertical split to right

-- Tags & Folding
o.tags = "./tmp/tags"                   -- Tags file location
o.foldenable = false                    -- Disable folding by default

-- Bells
o.errorbells = false                    -- No error bells
o.visualbell = false                    -- No visual bell

-- Window title
o.title = true                          -- Set window title

-- Neovide settings
if vim.g.neovide then
  g.neovide_input_use_logo = true
  g.neovide_opacity = 1
  g.neovide_normal_opacity = 0.8
  g.neovide_window_blurred = false
  g.neovide_floating_blur_amount_x = 10.0
  g.neovide_floating_blur_amount_y = 10.0
  g.neovide_floating_corner_radius = 0.5
  g.neovide_scroll_animation_length = 0.1
  g.neovide_cursor_vfx_mode = "pixiedust"
  g.neovide_cursor_animation_length = 0.05
  g.neovide_cursor_trail_size = 0.1
  g.neovide_touch_deadzone = 6.0
  g.neovide_touch_drag_timeout = 0.3
  g.neovide_underline_automatic_scaling = false
  g.neovide_refresh_rate = 120
  g.neovide_refresh_rate_idle = 5
  g.neovide_fullscreen = false
  g.neovide_remember_window_size = true
  g.neovide_cursor_animate_in_insert_mode = true
  g.neovide_cursor_animate_command_line = true
  g.neovide_floating_shadow = true
  g.neovide_floating_z_height = 10
  g.neovide_light_angle_degrees = 45
  g.neovide_light_radius = 5
  g.neovide_scroll_animation_far_lines = 1
  g.neovide_theme = 'auto'
  g.neovide_unlink_border_highlights = true
  g.neovide_input_macos_option_key_is_meta = 'only_left'
  g.neovide_padding_top = 0
  g.neovide_padding_left = 0
  g.neovide_padding_right = 0
  g.neovide_padding_bottom = 0
  g.startify_change_to_dir = 0
  g.netrw_banner = 0
  g.netrw_winsize = 25
end

-- Filetype autocmds
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.slim" },
  command = "set ft=slim"
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.jbuilder" },
  command = "set ft=ruby"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "eruby.yaml",
  command = "set ft=yaml"
})
