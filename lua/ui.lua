local M = {}

function M.get_width(lines)
  local width = 1
  for _, v in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(v)
    if len > width then
      width = len
    end
  end
  return width
end

function M.get_height(lines)
  if #lines < 1 then
    return 1
  end
  return #lines
end

function M.show(lines, row, col, text)
  local width = M.get_width(lines)
  local row = M.get_height(lines)

  local t = table.concat(vim.split(text, '\n'))
  local split_str = {}
  for i = 1, #t, width do
    table.insert(split_str, vim.fn.strcharpart(t, i, i + width - 1))
  end

  local height = #split_str
  local bufnr  = vim.api.nvim_create_buf(false, true)
  local win    = vim.api.nvim_open_win(
    bufnr,
    true,
    {
      relative = 'cursor',
      width = width,
      height = row,
      row = height,
      col = 5,
      focusable = true,
      style = 'minimal',
      border = 'rounded',
    }
  )
  vim.api.nvim_win_set_option(win, 'winblend', 50)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, split_str)
end

return M
