local builtin = require('telescope.builtin')

local function fileProgress()
  local chars = { '󰝦', '󰪞', '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪤', '󰪥', }
  -- local chars = { '󱩎', '󱩏', '󱩐', '󱩑', '󱩒', '󱩓', '󱩔', '󱩕', '󱩕', '󰛨', '󰛨', }
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  if total_lines < 20 then return '' end
  local i = math.floor(current_line / total_lines * 10)
  return chars[i + 1]..' '
end

local function spacer()
  return [[ ]]
end

local function iconScroll()
  -- local chars = { '󱖗', '󱖔', '󱖘', '󱖕', '󱖙', '󱖖', '󱖚', '󱖓', }
  local chars = { '🌘', '🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘', }
  local l = vim.fn.line('.')
  return chars[(l % 8) + 1]
end

local function iconMode()
  local icons = { n = ' 󰰓 󰌌', c = ' 󰯲 ', v = ' 󰰫 󰩬', V = ' 󰰫 󰫙', ["^V"] = ' 󰰫 󱊁', i = ' 󰰄 󰗧', b = ' 󰯯 ', t = ' 󰰥 ', nt = ' 󰰥 ', }
  return icons[vim.api.nvim_get_mode().mode] or ' 󰰫 󱊁'
end

local function modeColor()
  local colors = { n = '#98c279', c = '#e5c07b', v = '#c678dd', V = '#c678dd', ["^V"] = '#c678dd', i = '#61afef' }
  return colors[vim.api.nvim_get_mode().mode] or '#98c279'
end

local function iconTime()
  local now = os.date("*t")
  local hours = { '󱑊', '󱐿', '󱑀', '󱑁', '󱑂', '󱑃', '󱑄', '󱑅', '󱑆', '󱑇', '󱑈', '󱑉', '󱑊', '󱐿', '󱑀', '󱑁', '󱑂', '󱑃', '󱑄', '󱑅', '󱑆', '󱑇', '󱑈', '󱑉', }
  local m = string.format('%02d', now.min):gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼'):gsub('0', '󰎡')
  local h = string.format('%02d', now.hour):gsub('10', '󰎤󰎡'):gsub('20', '󰎧󰎡'):gsub('0', '󰎡'):gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼')
  -- return string.format('%s %s󰧌%s', hours[now.hour + 1], h, m)
  return string.format(' %s %s%s%s', '%#LuaLineTimeIcon#' .. hours[3], '%#LuaLineTimeHours#' .. h, '%#LuaLineTimeSplit#' .. '󰍵', '%#LuaLineTimeMinutes#' .. m)
end

local function transform(val)
  return val:gsub('1', '󰎤'):gsub('2', '󰎧'):gsub('3', '󰎪'):gsub('4', '󰎭'):gsub('5', '󰎱'):gsub('6', '󰎳'):gsub('7', '󰎶'):gsub('8', '󰎹'):gsub('9', '󰎼'):gsub('0', '󰎡')
end

local function transform2(val)
  return val:gsub('1', '󰎦'):gsub('2', '󰎩'):gsub('3', '󰎬'):gsub('4', '󰎮'):gsub('5', '󰎰'):gsub('6', '󰎵'):gsub('7', '󰎸'):gsub('8', '󰎻'):gsub('9', '󰎾'):gsub('0', '󰎣')
end

local function iconLine()
  local t = vim.fn.line('$')
  local total = transform2(tostring(vim.fn.line('$')))
  local r,c = unpack(vim.api.nvim_win_get_cursor(0))
  local x = string.format(("%0"..string.len(tostring(t))).."d", r)
  local y = string.format("%02d", c + 1)
  if r > 999 then x = "󰎼󰎼󰎿" end
  if c > 99 then y = "󰎼󰎿" end
  -- return string.format('%s%s󰖳%s󱐕', y, x, total)
  return string.format('%s%s %s', '%#LuaLineLinesXPreIcon#󰿉%#LuaLineLinesXIcon#󰈚%#LuaLineLinesX#' .. transform(y), '%#LuaLineLinesYIcon#󰿉%#LuaLineLinesY#' .. transform(x), '%#LuaLineLinesTotalIcon#󰧭%#LuaLineLinesTotal#' .. total)
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
            'branch',
            -- color = { bg = '#333333', gui='italic,bold', fg='#e5c07b' },
            color = function(section)
              return { fg = modeColor(), gui='italic,bold', bg = 'none' }
            end,
            icon = '',
            -- separator = { left = ' ', right = ''},
            on_click = function(count, btn, keys)
              builtin.git_branches({
                prompt_title = '🔭',
                preview_title = '📖',
                prompt_prefix = ' ',
                git_icons = {
                  added = "󰐗 ",
                  changed = "󰆗 ",
                  copied = " ",
                  deleted = "󰅙 ",
                  renamed = " ",
                  unmerged = "󰀩 ",
                  untracked = "󰎔 ",
                }
              })
            end
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
            on_click = function(count, btn, keys)
              builtin.git_status({
                prompt_title = '🔭',
                preview_title = '📖',
                prompt_prefix = ' ',
                git_icons = {
                  added = "󰐗 ",
                  changed = "󰆗 " ,
                  copied = " ",
                  deleted = "󰅙 ",
                  renamed = " ",
                  unmerged = "󰀩 ",
                  untracked = "󰎔 ",
                }
              })
            end
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
          -- { spacer, padding = 0 },
          --{
          --nvimbattery,
          --padding=0,
          ---color = function(section)
          --return { fg = modeColor(), bg = '#000000' }
          --end,
          --},
          {
            iconTime,
            padding=0,
            -- color = {
            --   gui ='italic',
            --   fg = '#ffffff'
            -- },
            color = function(section)
              return { fg = modeColor(), bg = 'none' }
            end,
          },
          { spacer, padding = 0, color = { bg='none' } },
        },
      },
      -- tabline = {
      --   lualine_a = {'      '},
      --   lualine_b = {},
      --   lualine_c = {{
      --     'buffers',
      --     padding = 10,
      --     use_mode_colors = true,
      --     symbols = {
      --       modified = '',      -- Text to show when the buffer is modified
      --       alternate_file = '', -- Text to show to identify the alternate file
      --       directory =  '',     -- Text to show when the buffer is a directory
      --     },
      --   }},
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {}
      -- },
    }
    vim.cmd('highlight lualine_c_normal guibg=NONE')
  end,
}
