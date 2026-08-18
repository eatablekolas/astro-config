---@type LazySpec
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<M-,>", "<cmd>ClaudeCodeFocus<cr>", mode = { "n", "x" } },
    { "<Leader>a", desc = "AI/Claude Code" },
    { "<Leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<Leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<Leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<Leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<Leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
    { "<Leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer" },
    { "<Leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
    { "<Leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<Leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject diff" },
  },
  opts = {
    terminal = {
      ---@module "snacks"
      ---@type snacks.win.Config|{}
      snacks_win_opts = {
        position = "float",
        width = 0.9,
        height = 0.9,
        keys = {
          claude_hide = {
            "<M-,>",
            function(self) self:hide() end,
            mode = "t",
            desc = "Hide",
          },
        },
      },
    },
  },
}
