local api, fn = vim.api, vim.fn
local anno = require('doxycpp.annotation')
local comm = require('doxycpp.comment')
local conf = require('doxycpp.config')

local doxycpp = {}

doxycpp.__index = doxycpp

function doxycpp.__newindex(table, key, val)
  if doxycpp[key] ~= nil then
    return
  end
  rawset(table, key, val)
end

-- generate line comment
local function gen_line_comment(lines, lnum, append)
  append = append or false
  if append == true then
    api.nvim_buf_set_lines(0, lnum - 1, lnum - 1, true, lines)
    return
  end
  api.nvim_buf_set_lines(0, lnum - 1, lnum + #lines - 1, true, lines)
end

-- normal mode
function doxycpp.normal()
  local lnum = fn.line('.')
  local cur_line = api.nvim_get_current_line()
  local cm_lines = anno.annotacomment(cur_line)

  local preline = api.nvim_buf_get_lines(0, lnum - 2, lnum - 1, true)[1]

  if cm_lines ~= nil then
    if preline:match('^%s*template') ~= nil then
      lnum = lnum - 1
    end
    gen_line_comment(cm_lines, lnum, true)
    api.nvim_win_set_cursor(0, { lnum + 1, #api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1] + 1 })

    vim.cmd('startinsert!')
  else
    cm_lines = comm.gen_comment(lnum, lnum)

    if cm_lines ~= nil then
      gen_line_comment(cm_lines, lnum, false)
    end
  end
end

-- visual mode
function doxycpp.visual()
  local line_start = vim.fn.getpos('v')[2]
  local line_end = vim.fn.getcurpos("'>")[2]
  print("line_start: " .. line_start)
  print("line_end: " .. line_end)

  local cm_lines = comm.gen_comment(line_start, line_end)
  if cm_lines ~= nil then
    gen_line_comment(cm_lines, line_start)
  end
  api.nvim_feedkeys(api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
end

function doxycpp:gen_annoment()
  local mode = fn.mode()
  local enable_mode = { 'n', 'v', 'V', '' }

  if vim.tbl_contains(enable_mode, mode) ~= true then
    return
  end

  -- normal mode
  if mode == 'n' then
    self.normal()
  end

  -- visual mode
  if mode ~= 'n' then
    self.visual()
  end
end

function doxycpp.setup(opts)
  conf:init(opts)
end

return setmetatable({}, doxycpp)

