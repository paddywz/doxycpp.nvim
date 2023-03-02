local doxycpp = require('doxycpp.core')
local api, fn = vim.api, vim.fn

-- add comment
local function add_comment(line)
  local newline
  local _, cur_spaces = line:find('^%s+')

  if cur_spaces == nil then
    newline = '// ' .. line
  else
    newline = line:sub(1, cur_spaces) .. '// ' .. line:sub(cur_spaces + 1, -1)
  end
  return newline
end

-- cancel comment
local function cancel_comment(line)
  local newline = line:gsub('// ', '')
  return newline
end

-- visual comment
local function vcomment(line_start, line_end)
  local lines = fn.getline(line_start, line_end)

  local res = {}
  for _, v in pairs(lines) do
    local newline = ""

    if #v > 0 then
      if v:match('// ') ~= nil then
        newline = cancel_comment(v)
      else
        newline = add_comment(v)
      end
    end
    table.insert(res, newline)
  end

  return res
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

local function gen_comment()
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
    cm_lines = doxycpp.annotacomment(cur_line)

    if cm_lines ~= nil then
      gen_line_comment(cm_lines, lnum, true)
      api.nvim_win_set_cursor(0, { lnum + 1, #api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1] + 1 })
      print(api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1])
      print(#api.nvim_buf_get_lines(0, lnum, lnum + 1, true)[1] + 1)

      -- vim.cmd('startinsert')
    else
      cm_lines = vcomment(lnum, lnum)
      gen_line_comment(cm_lines, lnum, false)
    end
    return
  end

  -- visual mode
  if mode ~= 'n' then
    local line_start = vim.fn.getpos('v')[2]
    local line_end = vim.fn.getcurpos("'>")[2]

    cm_lines = vcomment(line_start, line_end)
    gen_line_comment(cm_lines, line_start)
    api.nvim_feedkeys(api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
  end
end

-- create command
local group = api.nvim_create_augroup("DoxyCpp", {clear = true})

api.nvim_create_autocmd("filetype", {
  pattern = "cpp",
  group = group,
  callback = function()
    api.nvim_create_user_command("DoxyCpp", function()
      gen_comment()
    end, {})
  end
})

