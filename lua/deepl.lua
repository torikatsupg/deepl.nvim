local M = {}

M.translate = function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "v", false)
  vim.defer_fn(
    function()
      local strategy = require 'strategy'
      local ui = require 'deepl_ui'
      local mode           = strategy.detect_mode()
      local lines          = strategy.get_text(mode)
      local result         = require 'deepl_client'.hit_api(table.concat(lines, '\n'))
      ui.show(result)
    end, 0)
end

return M
