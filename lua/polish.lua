-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Neovide setup
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font Mono:h12"

  vim.g.neovide_progress_bar_enabled = false
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true

  vim.cmd("NeovideRegisterRightClick")

  -- F11 -> Toggle fullscreen
  vim.keymap.set("n", "<F11>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end)
end
