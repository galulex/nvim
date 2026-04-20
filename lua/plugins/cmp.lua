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
    -- Rails-specific sources
    { "wassimk/cmp-rails-fixture-names", version = "*", ft = "ruby" },
    { "wassimk/cmp-rails-fixture-types", version = "*", ft = "ruby" },
    -- For Rails views with CSS/HTML
    {
      "Jezda1337/nvim-html-css",
      config = function()
        require("html-css"):setup()
      end,
    },
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")
    -- require("copilot_cmp").setup()

    -- create an autocommand which closes cmp when ai completions are displayed
    vim.api.nvim_create_autocmd("User", {
      pattern = "NeoCodeiumCompletionDisplayed",
      callback = function() require("cmp").abort() end
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
    require'luasnip'.filetype_extend('ruby', { 'rails' })
    require'luasnip'.filetype_extend('eruby', { 'html', 'rails' })
    require'luasnip'.filetype_extend('slim', { 'html', 'rails' })

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
      -- Disable fuzzy matching for more relevant results
      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = true,
        disallow_prefix_unmatching = false,
      },
      -- Better sorting for Rails/JS development
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      window = {
        completion = {
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          winhighlight = 'Normal:CmpNormal,CursorLine:PmenuSel,Search:CmpSearch',

          scrolloff = 0,
          col_offset = 0,
          side_padding = 0,
          scrollbar = false,
        },
        documentation = {
          -- max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
          -- max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
          border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          winhighlight = 'Normal:CmpNormal,CursorLine:PmenuSel,Search:CmpSearch',
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
        fetching_timeout = 200, -- Reduced for snappier completions
        throttle = 30,
        debounce = 30,
        async_budget = 1,
        max_view_entries = 15 -- Fewer entries for faster rendering
      },
      sources = cmp.config.sources({
        -- { name = "copilot", priority = 1100 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "rails-fixture-names", priority = 700 },
        { name = "rails-fixture-types", priority = 700 },
      }, {
        { name = "buffer", priority = 500, keyword_length = 2 }, -- Lower keyword length
        { name = "path", priority = 300 },
        { name = "nvim-html-css", priority = 300 },
        { name = "rg", keyword_length = 3, max_item_count = 8, priority = 100 }, -- More useful ripgrep
      }),
    })

    -- ERB/Slim view files: bump nvim-html-css priority for view completions
    cmp.setup.filetype({'eruby', 'slim'}, {
      sources = cmp.config.sources({
        -- { name = "copilot", priority = 1100 },
        { name = 'nvim_lsp', priority = 1000 }, -- Tailwind/HTML/CSS LSP completion
        { name = 'nvim-html-css', priority = 900 },
        { name = 'luasnip', priority = 750 },
      }, {
        { name = 'buffer', keyword_length = 2, priority = 500 },
        { name = 'path', priority = 300 },
        { name = 'rg', keyword_length = 3, max_item_count = 8, priority = 100 },
      })
    })

    -- Custom highlights - theme agnostic by extracting colors from standard highlight groups
    local function get_hl(name, attr)
      local hl = vim.api.nvim_get_hl(0, { name = name })
      return hl[attr]
    end

    -- Extract colors from standard highlight groups
    local fg = get_hl("Normal", "fg")
    local yellow = get_hl("Title", "fg") or get_hl("DiagnosticWarn", "fg")
    local pink = get_hl("ErrorMsg", "fg") or get_hl("DiagnosticError", "fg")

    -- Popup menu highlights using transparent background
    vim.api.nvim_set_hl(0, "Pmenu", { bg = vim.g.colors.transparent, blend = 70 })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = vim.g.colors.transparent, blend = 70, bold = true, fg = pink })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = vim.g.colors.transparent, blend = 70 })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = fg, blend = 90 })

    -- CMP-specific highlights
    vim.api.nvim_set_hl(0, "CmpNormal", { bg = vim.g.colors.transparent, blend = 70 })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = yellow, bold = true })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = yellow, bold = true })
    vim.api.nvim_set_hl(0, "CmpSearch", { fg = yellow, bold = true })
  end
}
