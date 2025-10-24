local function fileProgress()
  local chars = { '󰝦', '󰪞', '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪤', '󰪥', }
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  if total_lines < 20 then return '' end
  local i = math.floor(current_line / total_lines * 10)
  return chars[i + 1]..' '
end

local function spacer()
  return [[ ]]
end

local function iconMode()
  local icons = { n = ' 󰰓 󰌌', c = ' 󰯲 ', v = ' 󰰫 󰩬', V = ' 󰰫 󰫙', ["^V"] = ' 󰰫 󱊁', i = ' 󰰄 󰗧', b = ' 󰯯 ', t = ' 󰰥 ', nt = ' 󰰥 ', }
  return icons[vim.api.nvim_get_mode().mode] or ' 󰰫 󱊁'
end

local function modeColor()
  local colors = { n = '#98c279', c = '#e5c07b', v = '#c678dd', V = '#c678dd', ["^V"] = '#c678dd', i = '#61afef' }
  return colors[vim.api.nvim_get_mode().mode] or '#98c279'
end

local gradients = {
  n = { -- Normal mode - Green variations (#98c279)
    '#98c279', '#a0ca81', '#a8d289', '#b0da91', '#b8e299', '#c0eaa1', '#c8f2a9', '#d0fab1',
    '#c8f2a9', '#c0eaa1', '#b8e299', '#b0da91', '#a8d289', '#a0ca81', '#98c279', '#90ba71',
    '#88b269', '#80aa61', '#78a259', '#70a051', '#689849', '#609041', '#588839', '#508031',
    '#487829', '#407021', '#389819', '#309011', '#389819', '#407021', '#487829', '#508031',
    '#588839', '#609041', '#689849', '#70a051', '#78a259', '#80aa61', '#88b269', '#90ba71',
  },
  i = { -- Insert mode - Blue variations (#61afef)
    '#61afef', '#69b7f7', '#71bfff', '#79c7ff', '#81cfff', '#89d7ff', '#91dfff', '#99e7ff',
    '#91dfff', '#89d7ff', '#81cfff', '#79c7ff', '#71bfff', '#69b7f7', '#61afef', '#59a7e7',
    '#519fdf', '#4997d7', '#418fcf', '#3987c7', '#317fbf', '#2977b7', '#216faf', '#1967a7',
    '#115f9f', '#095797', '#01578f', '#004787', '#01578f', '#095797', '#115f9f', '#1967a7',
    '#216faf', '#2977b7', '#317fbf', '#3987c7', '#418fcf', '#4997d7', '#519fdf', '#59a7e7',
  },
  -- Single gradient for all visual modes
  visual_gradient = {
    '#c678dd', '#ce80e5', '#d688ed', '#de90f5', '#e698fd', '#ee9fff', '#f6a8ff', '#feb0ff',
    '#f6a8ff', '#ee9fff', '#e698fd', '#de90f5', '#d688ed', '#ce80e5', '#c678dd', '#be70d5',
    '#b668cd', '#ae60c5', '#a658bd', '#9e50b5', '#9648ad', '#8e40a5', '#86389d', '#7e3095',
    '#76288d', '#6e2085', '#661f7d', '#5e1775', '#661f7d', '#6e2085', '#76288d', '#7e3095',
    '#86389d', '#8e40a5', '#9648ad', '#9e50b5', '#a658bd', '#ae60c5', '#b668cd', '#be70d5',
  },
  c = { -- Command mode - Yellow variations (#e5c07b)
    '#e5c07b', '#edc883', '#f5d08b', '#fdd893', '#ffe09b', '#ffe8a3', '#fff0ab', '#fff8b3',
    '#fff0ab', '#ffe8a3', '#ffe09b', '#fdd893', '#f5d08b', '#edc883', '#e5c07b', '#ddb873',
    '#d5b06b', '#cda863', '#c5a05b', '#bd9853', '#b5904b', '#ad8843', '#a5803b', '#9d7833',
    '#95702b', '#8d6823', '#85601b', '#7d5813', '#85601b', '#8d6823', '#95702b', '#9d7833',
    '#a5803b', '#ad8843', '#b5904b', '#bd9853', '#c5a05b', '#cda863', '#d5b06b', '#ddb873',
  },
  t = { -- Terminal mode - Green variations
    '#98c279', '#a0ca81', '#a8d289', '#b0da91', '#b8e299', '#c0eaa1', '#c8f2a9', '#d0fab1',
    '#c8f2a9', '#c0eaa1', '#b8e299', '#b0da91', '#a8d289', '#a0ca81', '#98c279', '#90ba71',
    '#88b269', '#80aa61', '#78a259', '#70a051', '#689849', '#609041', '#588839', '#508031',
    '#487829', '#407021', '#389819', '#309011', '#389819', '#407021', '#487829', '#508031',
    '#588839', '#609041', '#689849', '#70a051', '#78a259', '#80aa61', '#88b269', '#90ba71',
  }
}

local function gradientBranch()
  local branch_name = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  if branch_name == "" then
    return ""
  end

  local current_mode = vim.api.nvim_get_mode().mode
  local gradient

  -- Use the same gradient for all visual modes
  if current_mode == 'v' or current_mode == 'V' or current_mode == '^V' then
    gradient = gradients.visual_gradient
  else
    gradient = gradients[current_mode] or gradients.n
  end

  -- Set git icon color to match the mode gradient
  local base_color = gradient[1] -- First color in gradient (base mode color)
  local git_icon_highlight = "LuaLineBranchGitIcon" .. current_mode
  vim.cmd(string.format("highlight %s guifg=%s gui=italic,bold", git_icon_highlight, base_color))

  local result = string.format("%%#%s#󰊢 ", git_icon_highlight)
  local len = string.len(branch_name)

  for i = 1, len do
    local char = string.sub(branch_name, i, i)
    local color_index = ((i - 1) % #gradient) + 1
    local color = gradient[color_index]
    local highlight_name = "LuaLineBranchGradient" .. current_mode .. color_index

    vim.cmd(string.format("highlight %s guifg=%s gui=italic,bold", highlight_name, color))
    result = result .. string.format("%%#%s#%s", highlight_name, char)
  end

  return result
end

local function transform(val)
  return val:gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼'):gsub('0', '󰎡')
end

local function iconLine()
  local t = vim.fn.line('$')
  local total = transform(tostring(vim.fn.line('$')))
  local r,c = unpack(vim.api.nvim_win_get_cursor(0))
  local x = string.format(("%0"..string.len(tostring(t))).."d", r)
  local y = string.format("%02d", c + 1)
  if r > 999 then x = "󰎼󰎼󰎿" end
  if c > 99 then y = "󰎼󰎿" end
  -- return string.format('%s%s󰖳%s󱐕', y, x, total)
  return string.format('%s%s %s', '%#LuaLineLinesXPreIcon#󰿉%#LuaLineLinesXIcon#󰈚%#LuaLineLinesX#' .. transform(y), '%#LuaLineLinesYIcon#󰿉%#LuaLineLinesY#' .. transform(x), '%#LuaLineLinesTotalIcon#󰈚%#LuaLineLinesTotal#' .. total)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
    require('lualine').setup {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_file_types = {'netrw'},
        -- component_separators = { left = '', right = ''},
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- section_separators = { left = ' ', right = ''},
        -- section_separators = { left = '', right = ''},
      },
      sections = {
        lualine_a = {
          { iconMode,
            padding = 0,
            color = function(section)
              return { fg = modeColor(), bg = 'none' }
            end,
            separator = { left = '', right = ' ' },
          },
          -- { 'mode' },
        },
        lualine_b = {
          {
            gradientBranch,
            color = { bg = 'none' },
          }
        },
        lualine_c = {
          { 'filetype',
            icon_only = true,
            padding = 0,
            color = { bg = 'none' },
            separator = { left = ' ', right = '' },
          },
          { 'filename',
            path = 1,
            padding = 0,
            symbols = {
              modified = '',  -- Text to show when the file is modified.
              readonly = '',  -- Text to show when the file is non-modifiable or readonly.
              unnamed = '',    -- Text to show for unnamed buffers.
              newfile = ' ',  -- Text to show for newly created file before first write
            },
            color = { bg = 'none', gui = 'bold' },
            -- separator = { left = '<', right = '' },
      --         -- section_separators = { left = '', right = ''},
          },
        },
        lualine_x = {
          { 'diagnostics',
            padding = 0,
            -- separator = { left = '', right = ''},
            color = { bg = 'none', gui='italic' },
            symbols = { error = '', warn = '', info = '', hint = '󱠂' },
          },
          { spacer, padding = 0, color = { bg = 'none' } },
          {
            'diff',
            colored = true,
            icon = '',
            padding = 1,
            separator = { left = ' ', right = ' '},
            color = { bg = 'none', gui='italic,bold' },
            symbols = { added = '󰐗 ', modified = '󰆗 ', removed = '󰅙 ' },
          },
          -- { iconScroll, padding=0, color = { bg=none, } },
        },
        lualine_y = {
          { 'fileformat',
            symbols = {
              unix = '', -- e712
              dos = '',  -- e70f
              mac = '',  -- e711
            },
            color = { bg='none', padding=0, fg='#ff704e' }
          },
          -- { 'location', color = { bg='#333333' }, padding = 0 },
          { fileProgress, padding=0, color = { bg='none', fg='#ff7a45' } },
          { iconLine,
            padding=0,
            color = function(section)
              return { fg = modeColor(), bg = 'none' }
            end,
          },
          -- { spacer, padding = 0, color = { bg='none' } },
        },
        lualine_z = {
          { spacer, padding = 0, color = { bg='none' } },
        },
      },
    }
    vim.cmd('highlight lualine_c_normal guibg=NONE')
  end,
}
