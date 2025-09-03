vim.keymap.set({"n", "i"}, "<D-s>", "<Cmd>w<CR>")
vim.keymap.set({"n", "i"}, "<D-a>", "<esc>ggVG<end>")
vim.keymap.set("n", "<D-c>", '"+y')
vim.keymap.set("n", "<D-v>", '"+p')
vim.keymap.set("i", "<D-v>", '<Esc>"+pa')
vim.keymap.set("c", "<D-v>", '<c-r>+')
vim.keymap.set("n", "<D-z>", 'u')
vim.keymap.set("i", "<D-z>", '<Esc>ua')

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set('v', '<C-Up>', '<esc>`<gv:m \'<-2<CR>gv')
vim.keymap.set('v', '<C-Down>', '<esc>`>gv:m \'>+1<CR>gv')
vim.keymap.set('n', '<C-Up>', 'mz:m-2<CR>`z')
vim.keymap.set('n', '<C-Down>', 'mz:m+<CR>`z')
vim.keymap.set('n', '<M-Up>', 'mz:m-2<CR>`z')
vim.keymap.set('n', '<M-Down>', 'mz:m+<CR>`z')

vim.keymap.set("n", "<C-S-tab>", "<Cmd>tabprevious<CR>")
vim.keymap.set("n", "<D-t>", "<Cmd>tabnew<CR>")

vim.keymap.set({ "n", "i" }, "<D-[>", "<Cmd>tabprevious<CR>")
vim.keymap.set({ "n", "i" }, "<D-Up>", "<Cmd>tabprevious<CR>")
vim.keymap.set({ "n", "i" }, "<C-S-tab>", "<Cmd>tabprevious<CR>")
vim.keymap.set({ "n", "i" }, "<D-]>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "i" }, "<D-Down>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "i" }, "<C-tab>", "<Cmd>tabnext<CR>")
vim.keymap.set({ "n", "i" }, "<D-w>", "<Cmd>q!<CR>")
vim.keymap.set({ "n", "i" }, "<C-e>", "<Cmd>q!<CR>")

vim.keymap.set("n", "<S-w>", "<Cmd>e %h<CR>")
vim.keymap.set('n', "<S-w>", ":e %:h<CR>")

vim.keymap.set({ "n", "v" }, "<M-Right>", "e")
vim.keymap.set({ "n", "v" }, "<M-Left>", "b")
vim.keymap.set("i", "<M-Right>", "<esc>wi")
vim.keymap.set("i", "<M-Left>", "<esc>bi")

vim.keymap.set("n", "<D-/>", "gcc", { remap = true })
vim.keymap.set("v", "<D-/>", "gc", { remap = true })
vim.keymap.set("i", "<D-/>", "<Esc>gcca", { remap = true })

vim.cmd [[
map gV :Eview<CR>
map gC :Econtroller<CR>
map gM :Emodel<CR>
map gH :Ehelper<CR>
map gJ :Ejavascript<CR>
map gS :Estylesheet<CR>
]]

vim.keymap.set("n", "<S-Tab>", "<Cmd>Telescope oldfiles theme=dropdown prompt_title=🕒 prompt_prefix= preview_title=🕒<CR>")
vim.keymap.set("n", "<D-o>", "<Cmd>Telescope find_files theme=dropdown prompt_prefix=🔍<CR>")
vim.keymap.set("n", "<C-p>", "<Cmd>Telescope find_files theme=dropdown prompt_prefix=🔍<CR>")
vim.keymap.set("n", "<D-S-o>", "<Cmd>Telescope lsp_references prompt_prefix=🔁<CR>")
vim.keymap.set("n", "<D-f>", "<Cmd>GrepCword<CR>")
vim.keymap.set('v', '<D-f>', "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>", { desc = 'Find by Grep (Visual)' })

-- Zoom keymaps for Neovide
if vim.g.neovide then
  vim.api.nvim_set_keymap("n", "<D-=>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  2.0)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<D-->", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<D-0>", ":lua vim.g.neovide_scale_factor = 1.0<CR>", { silent = true })
end
