--local opts = { noremap = true, silent = true }
local opts = { }

-- Short keymap function
local keymap = vim.api.nvim_set_keymap


-- Set leader
keymap("", ";", "<nop>", opts)
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

keymap("n", "<leader>f", ":FZF<cr>", opts)
keymap("n", "<leader>FH", ":History<cr>", opts)
keymap("n", "<leader>FB", ":Buffers<cr>", opts);
