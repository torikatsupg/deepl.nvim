local M = {}

M.translate = function() 
  local strategy = require 'strategy'
  local ui = require 'deepl_ui'
  local mode = strategy.detect_mode()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "v", false)
  vim.defer_fn(
    function()
      local lines          = strategy.get_text(mode)
      local result         = require 'deepl_client'.hit_api(table.concat(lines, '\n'))
      local row, col, _, _ = strategy.get_position()
      ui.show(lines, row, col, result)
    end, 0)
end

return M
