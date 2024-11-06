local api, fn = vim.api, vim.fn

local filetypes = {
  git = '󰬎󰬐󰬛 ',
  NeogitStatus = '󰬎󰬐󰬛 ',
  fugitive = '󰬎󰬐󰬛 ',
  TelescopePrompt = '󰭎 ',
  netrw = ' '
}

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
    return '  󰬕󰬌󰬞 '
  end
  return fn.pathshorten(fn.fnamemodify(file, ':p:~:t'))
end

local function flags(bufnr)
  local ret = {} --- @type string[]
  if vim.bo[bufnr].modified then
    ret[#ret + 1] = ''
  end
  if not vim.bo[bufnr].modifiable then
    ret[#ret + 1] = ' '
  end
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

local function separator(index, char)
  local selected = fn.tabpagenr()
  if selected == index then
    return '%#TabLineSelSeparator#' .. " "
  end
  return '%#TabLineSeparator#' .. char
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
local function get_diags(buflist, hl_base)
  local diags = {} --- @type string[]
  for _, ty in ipairs({ 'Error', 'Warn', 'Info', 'Hint' }) do
    local n = 0
    for _, bufnr in ipairs(buflist) do
      n = n + #vim.diagnostic.get(bufnr, { severity = ty })
    end
    if n > 0 then
      diags[#diags + 1] = ('%%#Diagnostic%s%s#%s'):format(ty, hl_base, icons[ty])
    end
  end

  return table.concat(diags, '')
end

local function brand()
  return '        %#TabLineBrand#󰫏 󱌮  '
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

  local hl = not selected and 'TabLineFillTab' or 'TabLineSel'
  local common = '%#' .. hl .. '#'
  local ret =
    string.format('%s%%%dT %s%s%s', common, index, devicon(bufnr, hl), title(bufnr), flags(bufnr))

  if #bufnrs > 1 then
    ret = string.format('%s%s(%d)', ret, common, #bufnrs)
  end

  return separator(index, '') .. ret .. get_diags(bufnrs, hl) .. '%T' .. separator(index, '') .. separator(index, ' ')
end
  -- section_separators = { left = '', right = ''},

local M = {}

M.tabline = function()
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
