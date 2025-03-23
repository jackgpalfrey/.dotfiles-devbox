local km = vim.keymap

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
km.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
km.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
km.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open file explorer
km.set('n', '<leader>pv', vim.cmd.Ex, { desc = "[P]roject [V]iew" })

-- Ctrl-S to Format and Save
km.set({ 'n', 'v', 'i' }, '<C-s>', function()
  vim.cmd.Format()
  vim.cmd.w()
  vim.cmd.stopinsert()
end, { desc = "Fomat and [S]ave" })

-- Support for Ctrl-f session manager
km.set("n", "<C-f>", "<cmd>terminal sesh<cr>i", { desc = "Switch session" })


-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- Moving selections with capital K and J
km.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "[K] Move selection up 1" })
km.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "[J] Move selection down 1" })


-- Modifier Rebinds
-- ( Binds that slightly change the original functionality of a bind )
km.set("n", "J", "mzJ`z")
km.set("n", "<C-d>", "<C-d>zz")
km.set("n", "<C-u>", "<C-u>zz")

-- d = { name = "[D]iagnostics" },

-- Make Ctrl-c emulate Esc
km.set("i", "<C-c>", "<Esc>")

-- Remove default Cap Q bind
km.set("n", "Q", "<nop>")
