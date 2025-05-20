return {
  "folke/noice.nvim",
  event = "VeryLazy",
  config = function()
    require("noice").setup({
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
        long_message_to_split = true,
      },
      cmdline = {
        title = '',
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " 󰰢 ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " 󰰢 ", lang = "regex" },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 1, 2 },
          },
          filter_options = {},
          win_options = {
            -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 1, 2 },
          },
          win_options = {
            -- winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
        mini = {
          enabled = true,
          view = "notify",
          opts = {},
        },
      },
    })
  end,
}
