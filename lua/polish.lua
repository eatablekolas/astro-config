-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local resession = require('resession')
vim.keymap.set('n', '<C-O>', resession.load) -- Ctrl + O -> Load a session
vim.keymap.set('n', '<C-s>', function () -- Ctrl + S -> Save current file and session
  vim.cmd('w')
  resession.save()
end)
