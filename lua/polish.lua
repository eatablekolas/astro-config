-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Neovide setup
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font Mono:h12"

  vim.g.neovide_progress_bar_enabled = false
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_message_area_drag_selection = true

  vim.cmd "NeovideRegisterRightClick"

  -- F11 -> Toggle fullscreen
  vim.keymap.set("n", "<F11>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end)
end

-- Pipe server
local server_path = vim.fn.has "win32" == 1 and "\\\\.\\pipe\\nvim-server"
  or vim.fs.joinpath(vim.fn.stdpath "run", "nvim-server.pipe")

local already_running = vim.tbl_contains(vim.fn.serverlist(), server_path)
if not already_running then
  local ok, err = pcall(vim.fn.serverstart, server_path)
  if ok then
    vim.notify("nvim-server pipe started successfully", vim.log.levels.INFO)
  else
    vim.notify("nvim-server pipe failed to start: " .. tostring(err), vim.log.levels.WARN)
  end
end
