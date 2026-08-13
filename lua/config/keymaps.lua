-- Comments
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true }) -- Ctrl + / -> Comment line
vim.keymap.set('v', '<C-_>', 'gc', { remap = true }) -- Ctrl + / -> Comment selection

-- Buffers
local buffer = require('astrocore.buffer')
vim.keymap.set('n', '<Tab>', function () buffer.nav(1) end) -- Tab -> Go to next buffer
vim.keymap.set('n', '<S-Tab>', function () buffer.nav(-1) end) -- Shift + Tab -> Go to previous buffer
vim.keymap.set('n', '<C-F4>', function () buffer.close() end) -- Ctrl + F4 -> Close buffer

-- Ctrl + S -> Save
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('i', '<C-s>', '<C-o>:w<cr>')

-- Line manipulation
-- Alt + J -> Move line down
vim.keymap.set('n', '<A-j>', ':m+<cr>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m+<cr>==gi')
-- Alt + Down -> Move line down
vim.keymap.set('n', '<A-down>', ':m+<cr>==')
vim.keymap.set('i', '<A-down>', '<Esc>:m+<cr>==gi')
-- Alt + K -> Move line up
vim.keymap.set('n', '<A-k>', ':m-2<cr>==')
vim.keymap.set('i', '<A-k>', '<Esc>:m-2<cr>==gi')
-- Alt + Up -> Move line up
vim.keymap.set('n', '<A-up>', ':m-2<cr>==')
vim.keymap.set('i', '<A-up>', '<Esc>:m-2<cr>==gi')

-- LSP actions
-- Make sure to disable Alt+Enter keybind for Windows terminal
vim.keymap.set({'n', 'i', 'v'}, '<M-cr>', vim.lsp.buf.code_action) -- Alt + Enter -> Code actions
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename) -- F2 -> Rename
vim.keymap.set('n', '<F12>', vim.lsp.buf.definition) -- F12 -> Go to definition

-- Mouse actions (should avoid using)
vim.keymap.set('n', 'C-LeftMouse', '<LeftMouse>:lua vim.lsp.buf.definition()<cr>') -- Ctrl + Click -> Go to definition
