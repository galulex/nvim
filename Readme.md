# 🚀 Neovim Configuration

> A powerful, feature-rich Neovim configuration tailored for modern development

## ✨ Features

- 🎨 **Beautiful UI** with transparent OneDark Pro theme
- 🔍 **Fuzzy Finding** with Telescope and custom grep functionality
- 🤖 **AI-Powered Development** with GitHub Copilot, Avante, and Claude Code
- 🌳 **Syntax Highlighting** with Treesitter
- 🔧 **LSP Integration** with auto-completion and diagnostics
- 📁 **File Management** with Neo-tree (file explorer)
- 📊 **Custom Status Line** with beautiful icons and information
- ⚡ **Fast Performance** with lazy loading
- 🎯 **Rails Development** optimized with specific keymaps

## 🛠️ Installation

### Prerequisites

- Neovim >= 0.8
- Git
- Node.js (for LSP servers)
- Ruby (for Rails development)
- Ripgrep (for fast searching)

### Quick Install

```bash
# Backup existing config (optional)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone https://github.com/galulex/nvim.git ~/.config/nvim

# Start Neovim - plugins will auto-install
nvim
```

### Manual Setup

1. **Install Neovim**:
   ```bash
   # macOS
   brew install neovim
   
   # Ubuntu/Debian
   sudo apt install neovim
   
   # Arch Linux
   sudo pacman -S neovim
   ```

2. **Install dependencies**:
   ```bash
   # Install ripgrep for fast searching
   brew install ripgrep chafa ctags fd typos-lsp # macOS
   sudo apt install ripgrep chafa ctags fd-find # Ubuntu
   
   # Install Node.js for LSP servers
   brew install node  # macOS
   curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
   sudo apt-get install -y nodejs  # Ubuntu
   ```

3. **Copy configuration**:
   ```bash
   cp -r . ~/.config/nvim/
   ```

4. **Launch Neovim**:
   ```bash
   nvim
   ```

## 📦 Plugins

### 🎨 UI & Appearance
- **[onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)** - Beautiful dark theme with transparency
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** - Customizable statusline with icons
- **[noice.nvim](https://github.com/folke/noice.nvim)** - Enhanced UI for messages and cmdline
- **[dressing.nvim](https://github.com/stevearc/dressing.nvim)** - Better default vim.ui interfaces

### 🔍 Navigation & Search
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder with custom grep
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - File explorer (disabled by default)
- **[satellite.nvim](https://github.com/lewis6991/satellite.nvim)** - Decorations for scrollbar

### 🤖 AI & Completion
- **[copilot.lua](https://github.com/zbirenbaum/copilot.lua)** - GitHub Copilot integration
- **[avante.nvim](https://github.com/yetone/avante.nvim)** - AI-powered coding assistant (disabled)
- **[claude-code.nvim](https://github.com/greggh/claude-code.nvim)** - Claude Code integration
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Completion engine with multiple sources

### 🌳 Language Support
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting and parsing
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Package manager for LSP servers

### 🔧 Development Tools
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git integration
- **[lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - LazyGit integration
- **[neogit](https://github.com/TimUntersberger/neogit)** - Git interface for Neovim
- **[comment.nvim](https://github.com/numToStr/Comment.nvim)** - Smart commenting
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Auto-close pairs
- **[nvim-surround](https://github.com/kylechui/nvim-surround)** - Surround text objects

### 🚄 Rails Specific
- **[vim-rails](https://github.com/tpope/vim-rails)** - Rails development support
- **[vim-slim](https://github.com/slim-template/vim-slim)** - Slim template support

## ⌨️ Key Mappings

### 🔧 General
| Key | Mode | Action |
|-----|------|--------|
| `<leader>` | | Space (leader key) |
| `<D-s>` | Normal/Insert | Save file |
| `<D-a>` | Normal/Insert | Select all |
| `<D-c>` | Normal | Copy to clipboard |
| `<D-v>` | Normal/Insert/Command | Paste from clipboard |
| `<D-z>` | Normal/Insert | Undo |
| `<D-/>` | Normal/Visual | Toggle comment |

### 🚀 Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<D-o>` | Normal | Open file (Telescope) |
| `<C-p>` | Normal | Open file (Telescope) |
| `<S-Tab>` | Normal | Recent files |
| `<D-S-o>` | Normal | LSP references |
| `<D-f>` | Normal/Visual | Find text (grep) |

### 📑 Tabs & Windows
| Key | Mode | Action |
|-----|------|--------|
| `<D-t>` | Normal | New tab |
| `<D-[>` / `<D-Up>` | Normal/Insert | Previous tab |
| `<D-]>` / `<D-Down>` | Normal/Insert | Next tab |
| `<D-w>` | Normal/Insert | Close tab |
| `<S-w>` | Normal | Open directory of current file |

### 🎯 Text Editing
| Key | Mode | Action |
|-----|------|--------|
| `<` / `>` | Visual | Indent/outdent (keeps selection) |
| `<C-Up>` / `<C-Down>` | Normal/Visual | Move lines up/down |
| `<M-Right>` / `<M-Left>` | Normal/Visual/Insert | Move by word |

### 🚄 Rails Development
| Key | Mode | Action |
|-----|------|--------|
| `gV` | Normal | Go to view |
| `gC` | Normal | Go to controller |
| `gM` | Normal | Go to model |
| `gH` | Normal | Go to helper |
| `gJ` | Normal | Go to JavaScript |
| `gS` | Normal | Go to stylesheet |

### 🎨 Neovide (GUI) Specific
| Key | Mode | Action |
|-----|------|--------|
| `<D-=>` | Normal | Zoom in |
| `<D-->` | Normal | Zoom out |
| `<D-0>` | Normal | Reset zoom |

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Plugin manager setup
│   │   ├── settings.lua    # Vim settings
│   │   └── tabline.lua     # Custom tabline
│   └── plugins/
│       ├── autopairs.lua   # Auto-close pairs
│       ├── avante.lua      # AI assistant (disabled)
│       ├── claude_code.lua # Claude Code integration
│       ├── cmp.lua         # Completion engine
│       ├── colorscheme.lua # Theme configuration
│       ├── copilot.lua     # GitHub Copilot
│       ├── gitsigns.lua    # Git integration
│       ├── lazygit.lua     # LazyGit integration
│       ├── lspconfig.lua   # LSP configuration
│       ├── lualine.lua     # Status line
│       ├── mason.lua       # LSP package manager
│       ├── neotree.lua     # File explorer
│       ├── noice.lua       # UI enhancements
│       ├── rails.lua       # Rails support
│       ├── telescope.lua   # Fuzzy finder
│       ├── treesitter.lua  # Syntax highlighting
│       └── ...
└── lazy-lock.json          # Plugin lock file
```

## 🎨 Theme & UI

- **Color Scheme**: OneDark Pro with transparency
- **Font**: Supports any Nerd Font for icons
- **Transparency**: Enabled for modern look
- **Status Line**: Custom with file progress, git status, and time
- **Icons**: Extensive use of Nerd Font icons throughout

## 🔍 Search & Navigation

- **Telescope**: Fuzzy finding with custom grep functionality
- **File Ignore**: Automatically ignores common build/cache directories
- **Custom Grep**: `GrepCword` command for searching current word
- **Visual Search**: Select text and press `<D-f>` to search

## 🤖 AI Integration

### GitHub Copilot
- **Tab**: Accept suggestion
- **M-]** / **M-[**: Next/previous suggestion
- Integrated with completion engine

### Claude Code
- Vertical split terminal integration
- 40% screen width allocation

### Avante (Disabled)
- Advanced AI assistant capabilities
- Can be enabled by setting `enabled = true` in `avante.lua`

## 🚄 Rails Development

Optimized for Ruby on Rails development with:
- **LSP**: Ruby LSP and Solargraph support
- **Auto-format**: Ruby files on save
- **Quick Navigation**: Rails-specific keymaps (gV, gC, gM, etc.)
- **Slim Templates**: Syntax highlighting and support

## 🛠️ Customization

### Adding New Plugins

1. Create a new file in `lua/plugins/`:
   ```lua
   -- lua/plugins/my-plugin.lua
   return {
     "username/plugin-name",
     config = function()
       -- plugin configuration
     end
   }
   ```

2. Restart Neovim - Lazy.nvim will auto-install

### Changing Theme

Edit `lua/plugins/colorscheme.lua`:
```lua
return {
  "your-theme/nvim",
  config = function()
    vim.cmd("colorscheme your-theme")
  end
}
```

### Custom Keymaps

Add to `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<your-key>", "<your-command>")
```

## 🐛 Troubleshooting

### Plugin Issues
```bash
# Remove plugin cache
rm -rf ~/.local/share/nvim/lazy/

# Restart Neovim
nvim
```

### LSP Not Working
```bash
# Check LSP servers
:Mason
# Install required servers: ruby-lsp, solargraph, etc.
```

### Performance Issues
```bash
# Check startup time
nvim --startuptime startup.log

# Disable heavy plugins temporarily
# Edit respective plugin files and set enabled = false
```

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Lua Guide for Neovim](https://neovim.io/doc/user/lua-guide.html)
- [Rails.vim](https://github.com/tpope/vim-rails)

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📄 License

This configuration is open source and available under the [MIT License](LICENSE).

---

*Happy coding! 🚀*
