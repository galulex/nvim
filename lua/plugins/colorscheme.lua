return {
  "olimorris/onedarkpro.nvim",
  priority = 1000,
  config = function()
    require("onedarkpro").setup({
      options = {
        transparency = true, -- Use a transparent background?
        lualine_transparency = true, -- Center bar transparency?
      },
      -- highlights = {
      --   lualine_c_normal = { fg = "#abb2bf", bg = "NONE" },
      -- },
    })
    vim.cmd("colorscheme onedark_dark")

    -- Define custom colors that can be reused across configs
    -- Note: #000001 is intentionally different from bg (#000000) to preserve transparency with blend
    vim.g.colors = {
      transparent = "#000001", -- Must differ from pure black to enable blend transparency
    }

    -- LuaLine custom highlights
    vim.cmd [[
    hi LuaLineTimeMinutes guifg=#aff05b
    hi LuaLineTimeSplit guifg=#b6e84e
    hi LuaLineTimeHours guifg=#bfde43
    hi LuaLineTimeIcon guifg=#c8d43a
    hi LuaLineLinesTotal guifg=#d2c934
    hi LuaLineLinesTotalIcon guifg=#dcbe30
    hi LuaLineLinesY guifg=#e6b32e
    hi LuaLineLinesYIcon guifg=#efa72f
    hi LuaLineLinesX guifg=#f89b31
    hi LuaLineLinesXIcon guifg=#ff9036
    hi LuaLineLinesXPreIcon guifg=#ff843d

    ]]

    -- Highlights using transparent background
    local transparent = vim.g.colors.transparent
    local get_hl = vim.api.nvim_get_hl

    vim.api.nvim_set_hl(0, "MsgArea", { bg = transparent, blend = 100 })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = transparent, blend = 70 })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = transparent, blend = 70 })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingError", {
      bg = transparent,
      fg = get_hl(0, { name = "DiagnosticError" }).fg,
      blend = 70
    })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", {
      bg = transparent,
      fg = get_hl(0, { name = "DiagnosticWarn" }).fg,
      blend = 70
    })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", {
      bg = transparent,
      fg = get_hl(0, { name = "DiagnosticInfo" }).fg,
      blend = 70
    })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", {
      bg = transparent,
      fg = get_hl(0, { name = "DiagnosticHint" }).fg,
      blend = 70
    })

    -- Setup mode-aware cursor line number coloring
    require('config.mode_colors').setup()
  end,
}
