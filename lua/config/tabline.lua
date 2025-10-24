local api, fn = vim.api, vim.fn

local gradient = {
  '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63', '#ff6658', '#ff704e', '#ff7a45', '#ff843d',
  '#ff9036', '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934', '#c8d43a', '#bfde43', '#b6e84e',
  '#aff05b', '#b6e84e', '#bfde43', '#c8d43a', '#d2c934', '#dcbe30', '#e6b32e', '#efa72f', '#f89b31',
  '#ff9036', '#ff843d', '#ff7a45', '#ff704e', '#ff6658', '#ff5e63', '#ff566f', '#ff507a', '#fd4a85',
}

local filetypes = {
  git = '󰬎󰬐󰬛 ',
  NeogitStatus = '󰬎󰬐󰬛 ',
  fugitive = '󰬎󰬐󰬛 ',
  TelescopePrompt = '󰭎 ',
  netrw = ' ',
  NeoTree = ' ',
}

local function transform(val)
  local replacements = {
    ['0'] = '󰎡',
    ['1'] = '󰎤',
    ['2'] = '󰎧',
    ['3'] = '󰎪',
    ['4'] = '󰎭',
    ['5'] = '󰎱',
    ['6'] = '󰎳',
    ['7'] = '󰎶',
    ['8'] = '󰎹',
    ['9'] = '󰎼',
  }

  return val:gsub('%d', replacements)
end

--- @param name string
--- @return {bg?:integer, fg?:integer}
local function get_hl(name)
  return api.nvim_get_hl(0, { name = name })
end

local buftypes = {
  help = function(file)
    return 'help:' .. fn.fnamemodify(file, ':t:r')
  end,
  quickfix = 'quickfix',
  terminal = function(file)
    local mtch = string.match(file, 'term:.*:(%a+)')
    return mtch or fn.fnamemodify(vim.env.SHELL, ':t')
  end,
}

local function title(bufnr)
  local filetype = vim.bo[bufnr].filetype

  if filetypes[filetype] then
    return filetypes[filetype]
  end

  local file = fn.bufname(bufnr)
  local buftype = vim.bo[bufnr].buftype

  local bt = buftypes[buftype]
  if bt then
    if type(bt) == 'function' then
      return bt(file)
    end
    return bt
  end

  if file == '' then
    return ' 󰬕󰬌󰬞 '
  end
  return fn.pathshorten(fn.fnamemodify(file, ':p:~:t'))
end

local function flags(bufnr)
  local ret = {} --- @type string[]
  if vim.bo[bufnr].modified then
    ret[#ret + 1] = ''
  end
  -- if not vim.bo[bufnr].modifiable then
  --   ret[#ret + 1] = ''
  -- end
  return table.concat(ret)
end

--- @type table<string,true>
local devhls = {}

--- @param bufnr integer
--- @param hl_base string
--- @return string
local function devicon(bufnr, hl_base)
  local file = fn.bufname(bufnr)
  local buftype = vim.bo[bufnr].buftype
  local filetype = vim.bo[bufnr].filetype
  local devicons = require('nvim-web-devicons')

  --- @type string, string
  local icon, devhl
  if filetype == 'fugitive' then
    --- @type string, string
    icon, devhl = devicons.get_icon('git')
  elseif filetype == 'Neogit' then
    --- @type string, string
    icon, devhl = devicons.get_icon('git')
  elseif filetype == 'vimwiki' then
    --- @type string, string
    icon, devhl = devicons.get_icon('markdown')
  elseif buftype == 'terminal' then
    --- @type string, string
    icon, devhl = devicons.get_icon('zsh')
  else
    --- @type string, string
    icon, devhl = devicons.get_icon(file, fn.expand('#' .. bufnr .. ':e'))
  end

  if icon then
    local hl = hl_base .. 'Dev' .. devhl
    if not devhls[hl] then
      devhls[hl] = true
      api.nvim_set_hl(0, hl, {
        fg = get_hl(devhl).fg,
        bg = get_hl(hl_base).bg,
      })
    end

    local hl_start = '%#' .. hl .. '#'
    local hl_end = '%#' .. hl_base .. '#'

    return string.format('%s%s%s ', hl_start, icon, hl_end)
  end
  return ''
end

local icons = {
  Error = '',
  Warn = '',
  Hint = '󱠂', -- 󰛨
  Info = '',
}

--- @param buflist integer[]
--- @param hl_base string
--- @return string
local function diags(buflist, hl_base)
  local diags = {} --- @type string[]

  for _, ty in ipairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
    local n = 0
    for _, bufnr in ipairs(buflist) do
      n = n + #vim.diagnostic.get(bufnr, { severity = ty })
    end
    if n > 0 then
      local hl = 'Diagnostic' .. ty .. hl_base

      -- Define highlight group if needed
      if not vim.g['tabline_diag_' .. hl] then
        local diag_hl = get_hl('Diagnostic' .. ty)
        local bg = get_hl(hl_base).bg or 0x000000
        api.nvim_set_hl(0, hl, { fg = diag_hl.fg, bg = bg })
        vim.g['tabline_diag_' .. hl] = true
      end

      diags[#diags + 1] = ('%%#%s#%s'):format(hl, icons[ty])
    end
  end

  return table.concat(diags, '')
end


local function brand()
  return '        %#TabLineBrand#󱌮  '
end

--- Global character position counter for gradient
local char_pos = 0

--- @param char_offset integer
--- @return string, integer
local function get_gradient_hl(char_offset)
  local color_idx = (char_offset % #gradient) + 1
  local color = gradient[color_idx]
  local hl_name = 'TabLineGradChar' .. char_offset

  if not vim.g['tabline_grad_char_defined_' .. char_offset] then
    local fg = get_hl('TabLine').fg or 0x000000
    api.nvim_set_hl(0, hl_name, { fg = fg, bg = color })
    vim.g['tabline_grad_char_defined_' .. char_offset] = true
  end

  return hl_name, color_idx
end

--- Apply gradient per character to a string
--- @param text string
--- @param start_pos integer
--- @return string, integer
local function apply_char_gradient(text, start_pos)
  local result = {}
  local pos = start_pos

  -- Use vim.fn.strcharpart to properly handle UTF-8 characters
  local char_count = fn.strchars(text)
  for i = 0, char_count - 1 do
    local char = fn.strcharpart(text, i, 1)
    local hl_name = get_gradient_hl(pos)
    result[#result + 1] = string.format('%%#%s#%s', hl_name, char)
    pos = pos + 1
  end

  return table.concat(result), pos
end

--- @param index integer
--- @param selected boolean
--- @return string
local function cell(index, selected)
  local buflist = fn.tabpagebuflist(index)
  local winnr = fn.tabpagewinnr(index)
  local bufnr = buflist[winnr]

  local bufnrs = vim.tbl_filter(function(b)
    return vim.bo[b].buftype ~= 'nofile'
  end, buflist)

  if selected then
    -- Use default TabLineSel
    local hl = 'TabLineSel'
    local count_prefix = ''

    if #bufnrs > 1 then
      count_prefix = string.format('%%#%s#%s ', hl, transform(tostring(#bufnrs)))
    end

    local ret = string.format(
      '%%#%s#%%%dT%s%s%s%s%s',
      hl,
      index,
      count_prefix,
      devicon(bufnr, hl),
      title(bufnr),
      diags(bufnrs, hl),
      flags(bufnr)
    )

    return ' %#TabLineSelSeparator#' .. ret .. '%T' .. '%#TabLineSelSeparator#  '
  else
    -- Gradient per character
    local start_char_pos = char_pos

    -- Get components
    local icon = devicon(bufnr, 'TabLine')
    local tab_title = title(bufnr)
    local tab_diags = diags(bufnrs, 'TabLine')
    local tab_flags = flags(bufnr)
    local count_str = ''

    if #bufnrs > 1 then
      count_str = transform(tostring(#bufnrs)) .. ' '
    end

    -- Apply gradient to each part
    local result_parts = {}
    local current_pos = start_char_pos

    -- Tab click target
    result_parts[#result_parts + 1] = string.format('%%%dT', index)

    -- Opening rounded separator
    local sep_color_start = gradient[(current_pos % #gradient) + 1]
    local sep_hl_left = 'TabLineRoundLeft' .. current_pos
    if not vim.g['tabline_round_left_' .. current_pos] then
      api.nvim_set_hl(0, sep_hl_left, { fg = sep_color_start, bg = get_hl('TabLineFill').bg or 0x000000 })
      vim.g['tabline_round_left_' .. current_pos] = true
    end
    result_parts[#result_parts + 1] = string.format('%%#%s#', sep_hl_left)
    current_pos = current_pos + 1

    -- Apply gradient to count (moved to beginning)
    if #count_str > 0 then
      local count_grad, new_pos = apply_char_gradient(count_str, current_pos)
      result_parts[#result_parts + 1] = count_grad
      current_pos = new_pos
    end

    -- Apply gradient to icon (strip existing highlight codes)
    local plain_icon = icon:gsub('%%#.-#', '')
    if #plain_icon > 0 then
      local icon_grad, new_pos = apply_char_gradient(plain_icon, current_pos)
      result_parts[#result_parts + 1] = icon_grad
      current_pos = new_pos
    end

    -- Apply gradient to title
    if #tab_title > 0 then
      local title_grad, new_pos = apply_char_gradient(tab_title, current_pos)
      result_parts[#result_parts + 1] = title_grad
      current_pos = new_pos
    end

    -- Apply gradient to diagnostics (strip existing highlight codes)
    local plain_diags = tab_diags:gsub('%%#.-#', '')
    if #plain_diags > 0 then
      local diags_grad, new_pos = apply_char_gradient(plain_diags, current_pos)
      result_parts[#result_parts + 1] = diags_grad
      current_pos = new_pos
    end

    -- Apply gradient to flags
    if #tab_flags > 0 then
      local flags_grad, new_pos = apply_char_gradient(tab_flags, current_pos)
      result_parts[#result_parts + 1] = flags_grad
      current_pos = new_pos
    end

    -- Closing rounded separator
    local sep_color_end = gradient[(current_pos % #gradient) + 1]
    local sep_hl_right = 'TabLineRoundRight' .. current_pos
    if not vim.g['tabline_round_right_' .. current_pos] then
      api.nvim_set_hl(0, sep_hl_right, { fg = sep_color_end, bg = get_hl('TabLineFill').bg or 0x000000 })
      vim.g['tabline_round_right_' .. current_pos] = true
    end
    result_parts[#result_parts + 1] = string.format('%%T%%#%s#', sep_hl_right)
    current_pos = current_pos + 1

    -- Update global character position
    char_pos = current_pos

    -- Space between tabs
    result_parts[#result_parts + 1] = '%#TabLineFill# '

    return table.concat(result_parts)
  end
end
  -- section_separators = { left = '󰘘', right = ''},

local M = {}

M.tabline = function()
  -- Reset character position at the start of each render
  char_pos = 0

  local parts = {} --- @type string[]

  local len = 0

  local sel_start --- @type integer

  for i = 1, fn.tabpagenr('$') do
    local selected = fn.tabpagenr() == i

    local part = cell(i, selected)

    --- @type integer
    local width = api.nvim_eval_statusline(part, { use_tabline = true }).width

    if selected then
      sel_start = len
    end

    len = len + width

    -- Make sure the start of the selected tab is always visible
    if sel_start and len > sel_start + vim.o.columns then
      break
    end

    parts[#parts + 1] = part
  end
  return brand() .. table.concat(parts) .. '%#TabLineFill#%='
end

local function hldefs()
  -- Base TabLine highlights
  local normal_fg = get_hl('Normal').fg
  local comment_fg = get_hl('Comment').fg

  api.nvim_set_hl(0, 'TabLineSelSeparator', { bg = 'NONE', fg = normal_fg })
  api.nvim_set_hl(0, 'TabLineSeparator', { bg = 'NONE', fg = normal_fg })
  api.nvim_set_hl(0, 'TabLineSel', { bg = 'NONE', fg = normal_fg, bold = true })
  api.nvim_set_hl(0, 'TabLineFillTab', { bg = comment_fg, fg = get_hl('Normal').bg })
  api.nvim_set_hl(0, 'TabLineBrand', { fg = '#f4468f', bold = true })

  -- Diagnostic highlights for TabLine
  for _, hl_base in ipairs({ 'TabLineSel', 'TabLineFill' }) do
    local bg = get_hl(hl_base).bg
    for _, ty in ipairs({ 'Warn', 'Error', 'Info', 'Hint' }) do
      local hl = get_hl('Diagnostic' .. ty)
      local name = ('Diagnostic%s%s'):format(ty, hl_base)
      api.nvim_set_hl(0, name, { fg = hl.fg, bg = bg })
    end
  end
end

local group = api.nvim_create_augroup('tabline', {})
api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = hldefs,
})
hldefs()

vim.opt.tabline = "%!v:lua.require'config.tabline'.tabline()"

return M
