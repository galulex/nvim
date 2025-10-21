local g = vim.g
local o = vim.opt

o.guifont = "Menlo:h17"
o.pumblend = 15
-- o.colo = "onedark"  -- Theme
o.number = true -- Print the line number in front of each line
o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
o.clipboard = "unnamedplus" -- uses the clipboard register for all operations except yank.
o.syntax = "on" -- When this option is set, the syntax with this name is loaded.
o.autoindent = true -- Copy indent from current line when starting a new line.
o.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
o.cursorlineopt = "number" -- Only highlight the line number, not the entire line
o.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
o.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent.
o.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
o.encoding = "UTF-8" -- Sets the character encoding used inside Vim.
o.ruler = true -- Show the line and column number of the cursor position, separated by a comma.
o.mouse = "a" -- Enable the use of the mouse. "a" you can use on all modes
o.title = true -- When on, the title of the window will be set to the value of 'titlestring'
o.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
o.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
o.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
o.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
o.inccommand = "split" -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
o.splitright = true
o.termguicolors = true
o.signcolumn = "yes"
o.backspace = "indent,eol,start"-- Intuitive backspacing.
o.incsearch = true              -- Highlight matches as you type.
o.hlsearch = true                      -- Highlight matches.
o.scrolloff=3                   -- Show 3 lines of context around the cursor.
vim.cmd('set nosol')            -- Keep cursor column when scrolling
o.shortmess="filmnrxtTI"          -- Disable intro message
o.list = true
o.listchars="trail:•"             -- Show spaces in end of line
o.autoread = true                 -- Update open files when changed externally
o.mousescroll="ver:1,hor:0"       -- Disables horizontal scroll
o.undofile = true
o.showtabline = 2 -- Always show tabline
o.winblend = 0
o.laststatus = 3
o.updatetime = 100 -- Sets update time to 100ms for faster completion
o.tags = "./tmp/tags"
o.foldenable = false

g.noeb = "vb t_vb="                 -- No beeping
-- g.settags = "./config/nvim/"

g.nobackup = true                     -- Don't make a backup before overwriting a file.
g.nowritebackup = true                -- And again.
g.noswapfile = true                   -- Disable swp files

-- vim.diagnostic.config({ virtual_text = false }) -- Disables Diagnostic inline text

if vim.g.neovide then
  g.neovide_input_use_logo=true
  g.neovide_opacity = 1
  g.neovide_normal_opacity = 0.8
  g.neovide_window_blurred = false
  -- g.neovide_transparency = 0.8
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
  g.neovide_padding_top=0
  g.neovide_padding_left=0
  g.neovide_padding_right=0
  g.neovide_padding_bottom=0
  g.startify_change_to_dir = 0
  g.netrw_banner = 0
  g.netrw_winsize = 25
end

-- vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = [[%s/\s\+$//e]] })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = { "*.slim" }, command = "set ft=slim" })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = { "*.jbuilder" }, command = "set ft=ruby" })
vim.api.nvim_create_autocmd("FileType", { pattern = "eruby.yaml", command = "set ft=yaml" })
