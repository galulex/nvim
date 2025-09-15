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

    -- vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { ctermfg = 8 })
    -- vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { ctermfg = 8 })
    -- vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { ctermfg = 8 })
    -- vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { ctermfg = 8 })

    vim.cmd [[
    hi TabLineSelSeparator guibg=NONE guifg=#ABB2BF
    hi TabLineSeparator guibg=NONE guifg=#ABB2BF
    hi TabLineSel guibg=NONE guifg=Normal gui=bold
    hi TabLineFillTab guibg=#ABB2BF guifg=black
    hi TabLineBrand guifg=#f4468f gui=bold
    hi DiagnosticWarnTablineSel guibg=NONE
    hi DiagnosticErrorTablineSel guibg=NONE
    hi DiagnosticInfoTablineSel guibg=NONE
    hi DiagnosticHintTablineSel guibg=NONE
    hi TreesitterContext guibg=#000001 blend=100
    hi TreesitterContextLineNumber guibg=#000001 blend=100

    hi DiagnosticWarnTablineFillTab guibg=#ABB2BF guifg=black
    hi DiagnosticErrorTablineFillTab guibg=#ABB2BF guifg=black
    hi DiagnosticInfoTablineFillTab guibg=#ABB2BF guifg=black
    hi DiagnosticHintTablineFillTab guibg=#ABB2BF guifg=black

    hi SatelliteSearch guifg=white
    hi SatelliteSearchCurrent guifg=yellow
    hi SatelliteBackground guibg=#000001 blend=100
    hi SatelliteBar guibg=#ABB2BF blend=90

    hi MsgArea guibg=#000001 blend=100

    hi TelescopeNormal guibg=#000001 blend=70
    hi TelescopeBorder guibg=#000001 guifg=InsertMode blend=70
    hi TelescopeSelection guibg=#000001 gui=bold blend=70

    hi FloatNormal guibg=#000001 blend=70
    hi FloatBorder guibg=#000001 guifg=InsertMode blend=70

    hi NoiceCmdlinePopup guibg=#000001 blend=70
    hi NoiceCompletionItemKindDefault guibg=#000001 blend=70

    hi Pmenu guibg=#000001 blend=70
    hi PmenuSel guibg=#000001 blend=100 gui=bold guifg=#f4468f
    hi PmenuSbar guibg=#000001 blend=100
    hi PmenuThumb guibg=#ABB2BF blend=90

    " Custom mode-aware cursor line number coloring (replacing modicator)
    hi CursorLineNr guifg=#98c379 gui=bold " Default/Normal mode - green

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

    " Neogit custom highlights to match OneDarkPro theme
    hi NeogitBranch guifg=#98c379 guibg=NONE
    hi NeogitRemote guifg=#61afef guibg=NONE
    hi NeogitHunkHeader guifg=#c678dd gui=bold guibg=NONE
    hi NeogitHunkHeaderHighlight guifg=#c678dd guibg=NONE gui=bold
    hi NeogitDiffAddHighlight guifg=#98c379 guibg=NONE
    hi NeogitDiffDeleteHighlight guifg=#e06c75 guibg=NONE
    hi NeogitDiffAdd guifg=#98c379 guibg=NONE
    hi NeogitDiffDelete guifg=#e06c75 guibg=NONE
    hi NeogitSectionHeader guifg=#e5c07b gui=bold guibg=NONE
    hi NeogitChangeModified guifg=#d19a66 guibg=NONE
    hi NeogitChangeAdded guifg=#98c379 guibg=NONE
    hi NeogitChangeDeleted guifg=#e06c75 guibg=NONE
    hi NeogitChangeRenamed guifg=#61afef guibg=NONE
    hi NeogitChangeCopied guifg=#56b6c2 guibg=NONE
    hi NeogitChangeUpdated guifg=#c678dd guibg=NONE
    hi NeogitChangeUntracked guifg=#be5046 guibg=NONE
    hi NeogitUntrackedfiles guifg=#be5046 guibg=NONE
    hi NeogitUnstagedchanges guifg=#d19a66 guibg=NONE
    hi NeogitStagedchanges guifg=#98c379 guibg=NONE
    hi NeogitUnpulledchanges guifg=#61afef guibg=NONE
    hi NeogitUnmergedchanges guifg=#e06c75 guibg=NONE
    hi NeogitRecentcommits guifg=#abb2bf guibg=NONE
    hi NeogitStashes guifg=#c678dd guibg=NONE
    hi NeogitCommitViewHeader guifg=#e5c07b gui=bold guibg=NONE
    hi NeogitFilePath guifg=#abb2bf guibg=NONE
    hi NeogitCommitViewDescription guifg=#abb2bf guibg=NONE
    hi NeogitPopupSectionTitle guifg=#e5c07b gui=bold guibg=NONE
    hi NeogitPopupBranchName guifg=#98c379 guibg=NONE
    hi NeogitPopupBold guifg=#abb2bf gui=bold guibg=NONE
    hi NeogitPopupSwitchKey guifg=#61afef guibg=NONE
    hi NeogitPopupOptionKey guifg=#c678dd guibg=NONE
    hi NeogitPopupConfigKey guifg=#d19a66 guibg=NONE
    hi NeogitPopupActionKey guifg=#e06c75 guibg=NONE
    hi NeogitPopupSwitchEnabled guifg=#98c379 guibg=NONE
    hi NeogitPopupSwitchDisabled guifg=#5c6370 guibg=NONE
    hi NeogitSignatureGood guifg=#98c379 guibg=NONE
    hi NeogitSignatureBad guifg=#e06c75 guibg=NONE
    hi NeogitSignatureMissing guifg=#d19a66 guibg=NONE
    hi NeogitSignatureNone guifg=#5c6370 guibg=NONE
    hi NeogitTagName guifg=#e5c07b guibg=NONE
    hi NeogitTagDistance guifg=#d19a66 guibg=NONE

    " Fix cursor row and selection highlights to be transparent
    hi NeogitCursorLine guibg=NONE
    hi NeogitHunkHeaderCursor guifg=#c678dd guibg=NONE gui=bold
    hi NeogitDiffHeaderCursor guifg=#abb2bf guibg=NONE

    " Fix Neogit background to match nvim background (transparent)
    hi NeogitNormal guibg=NONE
    hi NeogitNotificationInfo guibg=NONE
    hi NeogitNotificationWarning guibg=NONE
    hi NeogitNotificationError guibg=NONE
    ]]

    -- Setup mode-aware cursor line number coloring
    require('config.mode_colors').setup()

    -- Override neogit highlights after it loads to ensure transparency
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NeogitStatus",
      callback = function()
        vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeogitDiffContext", { fg = "#abb2bf", bg = "NONE" })
        -- vim.api.nvim_set_hl(0, "NeogitDiffContextCursor", { bg = "NONE" })
      end
    })
  end,
}
