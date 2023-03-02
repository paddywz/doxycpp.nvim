local api, fn = vim.api, vim.fn
local anno = require('doxycpp.annotation')
local comm = require('doxycpp.comment')

local doxycpp = {}

-- generate line comment
local function gen_line_comment(lines, lnum, append)
  append = append or false
  if append == true then
    api.nvim_buf_set_lines(0, lnum - 1, lnum - 1, true, lines)
    return
  end
  api.nvim_buf_set_lines(0, lnum - 1, lnum + #lines - 1, true, lines)
end

function doxycpp.gen_annoment()
  local mode = fn.mode()
  local cm_lines
  local enable_mode = { 'n', 'v', 'V', '' }

  if vim.tbl_contains(enable_mode, mode) ~= true then
    return
  end

  -- normal mode
  if mode == 'n' then
    local lnum = fn.line('.')
    local cur_line = api.nvim_get_current_line()
    cm_lines = anno.annotacomment(cur_line)

    if cm_lines ~= nil then
      gen_line_comment(cm_lines, lnum, true)
      api.nvim_win_set_cursor(0, { lnum + 1, #api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1] + 1 })

      vim.cmd('startinsert!')
    else
      cm_lines = comm.gen_comment(lnum, lnum)
      gen_line_comment(cm_lines, lnum, false)
    end
    return
  end

  -- visual mode
  if mode ~= 'n' then
    local line_start = vim.fn.getpos('v')[2]
    local line_end = vim.fn.getcurpos("'>")[2]

    cm_lines = comm.gen_comment(line_start, line_end)
    gen_line_comment(cm_lines, line_start)
    api.nvim_feedkeys(api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
  end
end

function doxycpp.setup(config)
  config = config or {}
end

return doxycpp
