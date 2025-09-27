local ignore_filetypes_list = {
    "venv", "__pycache__", "%.xlsx", "%.jpg", "%.png", "%.webp", "%.svg", "%.log", "tags",
    "%.pdf", "%.odt", "%.ico", "vcr/", "node_modules/", "storage/", "tmp/", "fixtures/"
}

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = ignore_filetypes_list,
        preview = {
          filesize_limit = 1, -- MB
          treesitter = false,
        },
        layout_config = {
          prompt_position = "top",
          horizontal = {
            width = 0.9,
            height = 0.8,
            preview_width = 0.6,
          },
        },
        sorting_strategy = "ascending",
        selection_caret = "👉🏻",
        results_title = "💬",
        multi_icon = "📌",
        prompt_title = "🔍",
        winblend = 50,
        path_display = { "truncate" },
        dynamic_preview_title = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-a>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
          },
          n = {
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-a>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!**/.git/*" }
          end,
        },
        buffers = {
          show_all_buffers = true,
          sort_mru = true,
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")

    -- Keep your existing GrepCword command
    local telescopebuiltin = require("telescope.builtin")
    local function grep_cword()
      return telescopebuiltin.live_grep({
        default_text = vim.fn.expand("<cword>"),
        only_sort_text = true,
        prompt_title = "🔎",
        prompt_prefix = "🔍 ",
        preview_title = "📄"
      })
    end
    vim.api.nvim_create_user_command("GrepCword", grep_cword, {})

    -- Telescope keymaps
    vim.keymap.set("n", "<S-Tab>", "<Cmd>Telescope oldfiles theme=dropdown prompt_title=🕒 prompt_prefix=🔍 preview_title=📄<CR>")
    vim.keymap.set("n", "<D-o>", "<Cmd>Telescope find_files theme=dropdown prompt_title=🔍 prompt_prefix=🔍 preview_title=📄<CR>")
    vim.keymap.set("n", "<C-p>", "<Cmd>Telescope find_files theme=dropdown prompt_title=🔍 prompt_prefix=🔍 preview_title=📄<CR>")
    vim.keymap.set("n", "<D-S-o>", "<Cmd>Telescope lsp_references prompt_title=🔍 prompt_prefix=🔍 preview_title=📄<CR>")
    vim.keymap.set("n", "<D-f>", "<Cmd>GrepCword<CR>")
    vim.keymap.set('v', '<D-f>', "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ') . ' prompt_title=🔎 prompt_prefix=\"🔍 \" preview_title=📄'<cr>", { desc = 'Find by Grep (Visual)' })
  end,
}
