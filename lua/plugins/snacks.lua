---@type LazySpec
return {
  "folke/snacks.nvim",
  init = function()
    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
      group = vim.api.nvim_create_augroup("snacks_explorer_close_last", { clear = true }),
      callback = function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        local valid_wins = {}
        for _, win in ipairs(wins) do
          if vim.api.nvim_win_is_valid(win) then
            local win_config = vim.api.nvim_win_get_config(win)
            if win_config.relative == "" then table.insert(valid_wins, win) end
          end
        end

        if #valid_wins <= 2 then
          local only_explorer = true

          for _, win in ipairs(valid_wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            if ft ~= "snacks_layout_box" then
              only_explorer = false
              break
            end
          end

          if only_explorer then vim.cmd "qa" end
        end
      end,
    })
  end,
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            layout = {
              width = 30,
            },
          },
          win = {
            input = {
              keys = {
                ["<leader>o"] = false,
              },
            },
            list = {
              keys = {
                ["<leader>o"] = "unfocus_explorer",
              },
            },
          },
          actions = {
            unfocus_explorer = function(picker)
              local target_win = nil
              for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "" then
                  target_win = win
                  break
                end
              end

              if target_win then
                vim.api.nvim_set_current_win(target_win)
              else
                vim.api.nvim_set_current_win(picker.main)
              end
            end,
          },
        },
      },
    },
  },
  keys = {
    {
      "<Leader><Space>",
      function() require("snacks").picker.smart() end,
      desc = "Smart find files",
    },
    {
      "<Leader>e",
      function() require("snacks").explorer.open() end,
      desc = "Toggle explorer",
    },
    {
      "<Leader>o",
      function()
        local snacks = require "snacks"
        local picker = snacks.picker.get({ source = "explorer" })[1]
        local current_ft = vim.bo.filetype

        if picker then
          if current_ft == "snacks_picker_list" or current_ft == "snacks_picker_input" then
            picker:action "unfocus_explorer"
          else
            picker:focus()
          end
        else
          snacks.explorer.open()
        end
      end,
      desc = "Toggle explorer focus",
    },
  },
}
