return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "ray-x/cmp-treesitter",
    "lukas-reineke/cmp-rg",
    "zbirenbaum/copilot-cmp",
    "onsails/lspkind.nvim",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    require("copilot_cmp").setup()

    -- create an autocommand which closes cmp when ai completions are displayed
    vim.api.nvim_create_autocmd("User", {
      pattern = "NeoCodeiumCompletionDisplayed",
      callback = function() require("cmp").abort() end
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    require'luasnip'.filetype_extend('ruby', { 'rails' })

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
      window = {
        completion = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          winhighlight = 'Normal:CmpNormal,CursorLine:PmenuSel,Search:None',

          scrolloff = 0,
          col_offset = 0,
          side_padding = 0,
          scrollbar = false,
        },
        documentation = {
          -- max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
          -- max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          winhighlight = 'Normal:CmpNormal,CursorLine:PmenuSel,Search:None',
        },
      },
      formatting = {
        fields = { "abbr", "kind" },
        expandable_indicator = true,
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          -- can also be a function to dynamically calculate max width such as 
          -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
          ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default

          symbol_map = {
            Array = '🅰️',
            Boolean = '☯️',
            Buffer = vim.g.iconBuffer,
            Class = '🆑',
            Color = '🎨',
            Constant = '🧊',
            Constructor = '🚧',
            Enum = '🧫',
            EnumMember = '🦠',
            Event = '📅',
            Field = '🔘',
            File = '🗄',
            Folder = '📁',
            Function = '🧵',
            Interface = '🧩',
            Key = '🔑',
            Keyword = '🔑',
            Method = '🧶',
            Module = '🚛',
            Namespace = '🪐',
            Null = '☢️',
            Number = '🔢',
            Object = '🅾️',
            Operator = '❎',
            Package = '📦',
            Property = '💊',
            Reference = '⛳',
            Snippet = '🌱',
            String = '🔠',
            Struct = '🧱',
            Text = '📜',
            TypeParameter = '🧬',
            Unit = '🗳',
            Value = '🧪',
            Variable = '🔻',
            Copilot = "🤖",
            OpenAI = "🤖",
          },

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
            vim_item.menu = ""
            return vim_item
          end

        })
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
        --   if cmp.visible() and has_words_before() then
        --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --   else
        --     fallback()
        --   end
        -- end),
      }),
      performance = { 
        fetching_timeout = 200,
        throttle = 60,
        debounce = 60,
        async_budget = 1,
        max_view_entries = 20
      },
      sources = cmp.config.sources({
        -- { name = "copilot" },
        -- { name = 'avante' },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        -- { name = 'treesitter' }, Neovim freeze susspect
        { name = "rg", keyword_length = 5, max_item_count = 5 },
      }),
    })
  end
}
