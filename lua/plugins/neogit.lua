return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function ()
    local neogit = require("neogit")

    neogit.setup {
      -- Hides the hints at the top of the status buffer
      disable_hint = false,
      -- Disables changing the buffer highlights based on where the cursor is.
      disable_context_highlighting = false,
      -- Disables signs for sections/items/hunks
      disable_signs = false,
      -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
      -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
      -- normal mode.
      disable_insert_on_commit = "auto",
      -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
      -- events.
      filewatcher = {
        interval = 1000,
        enabled = true,
      },
      -- "ascii"   is the graph the git CLI generates
      -- "unicode" is the graph like https://github.com/rbong/vim-flog
      graph_style = "ascii",
      -- Used to generate URL's for branch popup action "pull request".
      git_services = {
        ["github.com"] = {
          pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
          commit = "https://github.com/${owner}/${repository}/commit/${commit_sha}",
          tree = "https://github.com/${owner}/${repository}/tree/${branch_name}",
        },
        ["bitbucket.org"] = {
          pull_request = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
          commit = "https://bitbucket.org/${owner}/${repository}/commits/${commit_sha}",
          tree = "https://bitbucket.org/${owner}/${repository}/src/${branch_name}",
        },
        ["gitlab.com"] = {
          pull_request = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
          commit = "https://gitlab.com/${owner}/${repository}/commit/${commit_sha}",
          tree = "https://gitlab.com/${owner}/${repository}/tree/${branch_name}",
        },
        ["azure.com"] = {
          pull_request = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
          commit = "https://dev.azure.com/${owner}/_git/${repository}/commit/${commit_sha}",
          tree = "https://dev.azure.com/${owner}/_git/${repository}?path=/&version=GB${branch_name}",
        },
      },
      -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
      -- sorter instead. By default, this function returns `nil`.
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      -- Persist the values of switches/options within and across sessions
      remember_settings = true,
      -- Scope persisted settings on a per-project basis
      use_per_project_settings = true,
      -- Table of settings to never persist. Uses format "Filetype--cli-value"
      ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitRevertPopup--no-edit",
      },
      -- Configure highlight group features
      highlight = {
        italic = true,
        bold = true,
        underline = true
      },
      -- Set to false if you want to be responsible for creating _ALL_ keymappings
      use_default_keymaps = true,
      -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
      -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
      auto_refresh = true,
      -- Value used for `--sort` option for `git branch` command
      -- By default, branches will be sorted by commit date descending
      -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
      -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
      sort_branches = "-committerdate",
      -- Change the default way of opening neogit
      kind = "tab",
      -- Disable line numbers and relative line numbers
      disable_line_numbers = true,
      -- The time after which an output console is shown for slow running commands
      console_timeout = 100,
      -- Automatically show console if a command takes more than console_timeout milliseconds
      auto_show_console = true,
      -- Automatically close the console if the process exits with a 0 (success) status
      auto_close_console = true,
      status = {
        show_head_commit_hash = true,
        recent_commit_count = 10,
        HEAD_padding = 10,
        HEAD_folded = false,
        mode_padding = 3,
        mode_text = {
          M = "󰆗 ",
          N = "󰎔 ",
          A = "󰐗 ",
          D = "󰅙 ",
          C = " ",
          U = "󰆗 ",
          R = "󱆭 ",
          DD = "󰀩 ",
          AU = "󰀩 ",
          UD = "󰀩 ",
          UA = "󰀩 ",
          DU = "󰀩 ",
          AA = "󰀩 ",
          UU = "󰀩 ",
          ["?"] = "",
        },
      },
      commit_editor = {
        kind = "tab",
        show_staged_diff = true,
        -- Accepted values:
        -- "split" to show the staged diff below the commit editor
        -- "vsplit" to show it to the right
        -- "split_above" Like :top split
        -- "vsplit_left" like :vsplit, but open to the left
        -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
        staged_diff_split_kind = "split",
        spell_check = true,
      },
      commit_select_view = {
        kind = "tab",
      },
      commit_view = {
        kind = "vsplit",
        verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
      },
      log_view = {
        kind = "tab",
      },
      rebase_editor = {
        kind = "auto",
      },
      reflog_view = {
        kind = "tab",
      },
      merge_editor = {
        kind = "auto",
      },
      tag_editor = {
        kind = "auto",
      },
      preview_buffer = {
        kind = "floating",
      },
      popup = {
        kind = "split",
      },
      signs = {
        -- { CLOSED, OPENED }
        hunk = { "", "" },
        item = { "", "" },
        section = { "󰧚", "󰧖" },
      },
      -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
      integrations = {
        -- If enabled, use telescope for menu selection rather than vim.ui.select.
        -- Allows multi-select and some things that vim.ui.select doesn't.
        telescope = nil,
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
        -- The diffview integration enables the diff popup.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        diffview = nil,

        -- If enabled, uses fzf-lua for menu selection. If the telescope integration
        -- is also selected then telescope is used instead
        -- Requires you to have `ibhagwan/fzf-lua` installed.
        fzf_lua = nil,

        -- If enabled, uses mini.pick for menu selection. If the telescope integration
        -- is also selected then telescope is used instead
        -- Requires you to have `echasnovski/mini.pick` installed.
        mini_pick = nil,
      },
      sections = {
        -- Reverting/Cherry Picking
        sequencer = {
          folded = false,
          hidden = false,
        },
        untracked = {
          folded = false,
          hidden = false,
        },
        unstaged = {
          folded = false,
          hidden = false,
        },
        staged = {
          folded = false,
          hidden = false,
        },
        stashes = {
          folded = true,
          hidden = false,
        },
        unpulled_upstream = {
          folded = true,
          hidden = false,
        },
        unmerged_upstream = {
          folded = false,
          hidden = false,
        },
        unpulled_pushRemote = {
          folded = true,
          hidden = false,
        },
        unmerged_pushRemote = {
          folded = false,
          hidden = false,
        },
        recent = {
          folded = true,
          hidden = false,
        },
        rebase = {
          folded = true,
          hidden = false,
        },
      },
      mappings = {
        commit_editor = {
          ["q"] = "Close",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        commit_editor_I = {
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        rebase_editor = {
          ["p"] = "Pick",
          ["r"] = "Reword",
          ["e"] = "Edit",
          ["s"] = "Squash",
          ["f"] = "Fixup",
          ["x"] = "Execute",
          ["d"] = "Drop",
          ["b"] = "Break",
          ["q"] = "Close",
          ["<cr>"] = "OpenCommit",
          ["gk"] = "MoveUp",
          ["gj"] = "MoveDown",
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
          ["[c"] = "OpenOrScrollUp",
          ["]c"] = "OpenOrScrollDown",
        },
        rebase_editor_I = {
          ["<c-c><c-c>"] = "Submit",
          ["<c-c><c-k>"] = "Abort",
        },
        finder = {
          ["<cr>"] = "Select",
          ["<c-c>"] = "Close",
          ["<esc>"] = "Close",
          ["<c-n>"] = "Next",
          ["<c-p>"] = "Previous",
          ["<down>"] = "Next",
          ["<up>"] = "Previous",
          ["<tab>"] = "MultiselectToggleNext",
          ["<s-tab>"] = "MultiselectTogglePrevious",
          ["<c-j>"] = "NOP",
        },
        -- Setting any of these to `false` will disable the mapping.
        popup = {
          ["?"] = "HelpPopup",
          ["A"] = "CherryPickPopup",
          ["D"] = "DiffPopup",
          ["M"] = "RemotePopup",
          ["P"] = "PushPopup",
          ["X"] = "ResetPopup",
          ["Z"] = "StashPopup",
          ["b"] = "BranchPopup",
          ["B"] = "BisectPopup",
          ["c"] = "CommitPopup",
          ["f"] = "FetchPopup",
          ["l"] = "LogPopup",
          ["m"] = "MergePopup",
          ["p"] = "PullPopup",
          ["r"] = "RebasePopup",
          ["v"] = "RevertPopup",
          ["w"] = "WorktreePopup",
        },
        status = {
          ["k"] = "MoveUp",
          ["j"] = "MoveDown",
          ["q"] = "Close",
          ["o"] = "OpenTree",
          ["I"] = "InitRepo",
          ["1"] = "Depth1",
          ["2"] = "Depth2",
          ["3"] = "Depth3",
          ["4"] = "Depth4",
          ["<tab>"] = "Toggle",
          ["x"] = "Discard",
          ["s"] = "Stage",
          ["S"] = "StageUnstaged",
          ["<c-s>"] = "StageAll",
          ["K"] = "Untrack",
          ["u"] = "Unstage",
          ["U"] = "UnstageStaged",
          ["$"] = "CommandHistory",
          ["Y"] = "YankSelected",
          ["<c-r>"] = "RefreshBuffer",
          ["<cr>"] = "GoToFile",
          ["<s-cr>"] = "PeekFile",
          ["<c-v>"] = "VSplitOpen",
          ["<c-x>"] = "SplitOpen",
          ["<c-t>"] = "TabOpen",
          ["{"] = "GoToPreviousHunkHeader",
          ["}"] = "GoToNextHunkHeader",
          ["[c"] = "OpenOrScrollUp",
          ["]c"] = "OpenOrScrollDown",
          ["<c-k>"] = "PeekUp",
          ["<c-j>"] = "PeekDown",
        },
      },
    }

    -- Custom highlights - theme agnostic by extracting colors from standard highlight groups
    local function get_hl(name, attr)
      local hl = vim.api.nvim_get_hl(0, { name = name })
      return hl[attr]
    end

    -- Extract colors from standard highlight groups
    local green = get_hl("String", "fg") or get_hl("DiagnosticOk", "fg")
    local blue = get_hl("Function", "fg") or get_hl("DiagnosticInfo", "fg")
    local purple = get_hl("Keyword", "fg") or get_hl("Statement", "fg")
    local red = get_hl("DiagnosticError", "fg") or get_hl("ErrorMsg", "fg")
    local yellow = get_hl("Title", "fg") or get_hl("DiagnosticWarn", "fg")
    local cyan = get_hl("Type", "fg") or get_hl("Identifier", "fg")
    local orange = get_hl("Number", "fg") or get_hl("Constant", "fg")
    local gray = get_hl("Comment", "fg")
    local fg = get_hl("Normal", "fg")

    -- Branch and remote
    vim.api.nvim_set_hl(0, "NeogitBranch", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitRemote", { fg = blue, bg = "NONE" })

    -- Hunk headers
    vim.api.nvim_set_hl(0, "NeogitHunkHeader", { fg = purple, bold = true, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", { fg = purple, bold = true, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitHunkHeaderCursor", { fg = purple, bold = true, bg = "NONE" })

    -- Diff highlights
    vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitDiffAdd", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitDiffHeaderCursor", { fg = fg, bg = "NONE" })

    -- Section headers
    vim.api.nvim_set_hl(0, "NeogitSectionHeader", { fg = yellow, bold = true, bg = "NONE" })

    -- Change types
    vim.api.nvim_set_hl(0, "NeogitChangeModified", { fg = orange, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitChangeAdded", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitChangeDeleted", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitChangeRenamed", { fg = blue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitChangeCopied", { fg = cyan, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitChangeUpdated", { fg = purple, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitChangeUntracked", { fg = red, bg = "NONE" })

    -- Section names
    vim.api.nvim_set_hl(0, "NeogitUntrackedfiles", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitUnstagedchanges", { fg = orange, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitStagedchanges", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitUnpulledchanges", { fg = blue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitUnmergedchanges", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitRecentcommits", { fg = fg, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitStashes", { fg = purple, bg = "NONE" })

    -- Commit view
    vim.api.nvim_set_hl(0, "NeogitCommitViewHeader", { fg = yellow, bold = true, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitFilePath", { fg = fg, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitCommitViewDescription", { fg = fg, bg = "NONE" })

    -- Popup menu
    vim.api.nvim_set_hl(0, "NeogitPopupSectionTitle", { fg = yellow, bold = true, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupBranchName", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupBold", { fg = fg, bold = true, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupSwitchKey", { fg = blue, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupOptionKey", { fg = purple, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupConfigKey", { fg = orange, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupActionKey", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupSwitchEnabled", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitPopupSwitchDisabled", { fg = gray, bg = "NONE" })

    -- Signatures
    vim.api.nvim_set_hl(0, "NeogitSignatureGood", { fg = green, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitSignatureBad", { fg = red, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitSignatureMissing", { fg = orange, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitSignatureNone", { fg = gray, bg = "NONE" })

    -- Tags
    vim.api.nvim_set_hl(0, "NeogitTagName", { fg = yellow, bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitTagDistance", { fg = orange, bg = "NONE" })

    -- Cursor and selection (transparent)
    vim.api.nvim_set_hl(0, "NeogitCursorLine", { bg = "NONE" })

    -- Background (transparent)
    vim.api.nvim_set_hl(0, "NeogitNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitNotificationInfo", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitNotificationWarning", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeogitNotificationError", { bg = "NONE" })

    -- Override additional highlights after Neogit loads to ensure transparency
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NeogitStatus",
      callback = function()
        vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeogitDiffContext", { fg = fg, bg = "NONE" })
      end
    })
  end
}
