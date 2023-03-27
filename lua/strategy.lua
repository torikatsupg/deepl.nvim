local M = {}

function M.detect_mode()
  local mode = vim.fn.visualmode()
  if mode == 'v' then
    return 'cursor'
  elseif mode == 'V' then
    return 'line'
  else
    return 'blockwise'
  end
end

function M.get_position()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  return start_pos[2], start_pos[3], end_pos[2], end_pos[3]
end

function M.get_selected_lines(start_row, end_row)
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)
end

function M.cursor()
  local start_row, start_col, end_row, end_col = M.get_position()
  local lines = M.get_selected_lines(start_row, end_row)

  local results = {}
  for i, line in ipairs(lines) do
    if i == 1 then
      if start_row == end_row then
        results[i] = vim.fn.strcharpart(line, start_col, end_col)
      else
        results[i] = vim.fn.strcharpart(line, start_col)
      end
    elseif i == length then
      results[i] = vim.fn.strcharpart(line, 0, end_col)
    else
      results[i] = line
    end
  end
  return results
end

function M.line()
  local start_row, _, end_row, _ = M.get_position()
  return M.get_selected_lines(start_row, end_row) or {}
end

function M.blockwise()
  local start_row, start_col, end_row, end_col = M.get_position()
  local lines = M.get_selected_lines(start_row, end_row)

  local results = {}
  for i, line in ipairs(lines) do
    results[i] = vim.fn.strcharpart(line, start_col + 1, end_col)
  end
  return results
end

function M.get_text(mode)
  if mode == 'cursor' then
    return M.cursor()
  elseif mode == 'line' then
    return M.line()
  else
    return M.blockwise()
  end
end

return M
