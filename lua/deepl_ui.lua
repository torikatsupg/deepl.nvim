local M = {}

local function split_string(str, width)
  local index = 0
  local length = vim.fn.strdisplaywidth(str)

  local result = {}
  while index <= length do
    table.insert(result, vim.fn.strcharpart(str, index, index + width))
    index = index + width
  end
  return result
end

function M.show(text)
  local current_bufnr = vim.api.nvim_get_current_win()
  local window_width = vim.api.nvim_win_get_width(current_bufnr)
  local width = math.floor(window_width * 0.6)

  -- 2 is total horizontal border width

  local split_str = {}
  local text_width = math.max(0, width - 2)
  for _, line in ipairs(vim.split(text, "\n")) do
    local splitted_line = split_string(line, text_width)
    for _, v in ipairs(splitted_line) do
      table.insert(split_str, v)
    end
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(
    bufnr,
    true,
    {
      relative = 'cursor',
      width = width,
      height = #split_str - 1,
      row = 1,
      col = 0,
      focusable = false,
      style = 'minimal',
      border = 'rounded',
    }
  )
  vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, split_str)
end

return M
