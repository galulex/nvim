-- Mode-aware cursor line number coloring
local M = {}

-- Get theme colors dynamically
local function get_theme_colors()
  local ok, helpers = pcall(require, "onedarkpro.helpers")
  if not ok then
    -- Fallback to hardcoded colors if OneDarkPro is not available
    return {
      green = '#98c379',
      blue = '#61afef',
      purple = '#c678dd',
      yellow = '#e5c07b',
      red = '#e06c75',
      cyan = '#56b6c2',
    }
  end

  local colors = helpers.get_colors()
  return {
    green = colors.green,
    blue = colors.blue,
    purple = colors.purple,
    yellow = colors.yellow,
    red = colors.red,
    cyan = colors.cyan,
  }
end

-- Mode color mappings using theme colors
local function get_mode_colors()
  local theme_colors = get_theme_colors()
  return {
    ['n'] = theme_colors.green,    -- Normal - green
    ['i'] = theme_colors.blue,     -- Insert - blue
    ['v'] = theme_colors.purple,   -- Visual - purple
    ['V'] = theme_colors.purple,   -- Visual Line - purple
    ['\22'] = theme_colors.purple, -- Visual Block - purple (Ctrl-V)
    ['c'] = theme_colors.yellow,   -- Command - yellow
    ['s'] = theme_colors.purple,   -- Select - purple
    ['S'] = theme_colors.purple,   -- Select Line - purple
    ['\19'] = theme_colors.purple, -- Select Block - purple
    ['r'] = theme_colors.red,      -- Replace - red
    ['R'] = theme_colors.red,      -- Replace - red
    ['t'] = theme_colors.cyan,     -- Terminal - cyan
  }
end

-- Update cursor line number highlight based on current mode
function M.update_cursor_highlight()
  local mode = vim.fn.mode()
  local colors = get_mode_colors()
  local color = colors[mode] or get_theme_colors().green
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = color, bold = true, bg = 'NONE' })
end

-- Setup mode color highlighting with autocmds
function M.setup()
  -- Set initial highlight
  M.update_cursor_highlight()

  -- Update on mode changes
  vim.api.nvim_create_autocmd('ModeChanged', {
    callback = M.update_cursor_highlight
  })

  -- Also update on insert enter/leave for better responsiveness
  vim.api.nvim_create_autocmd({'InsertEnter', 'InsertLeave'}, {
    callback = M.update_cursor_highlight
  })
end

return M