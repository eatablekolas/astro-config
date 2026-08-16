---@type LazySpec
return {
  "stevearc/resession.nvim",
  keys = {
    {
      "<C-o>",
      require("resession").load,
    },
    {
      "<C-s>",
      function()
        vim.cmd "w"
        require("resession").save()
      end,
    },
  },
}
