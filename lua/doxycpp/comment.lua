local config = require('doxycpp.config').config.comment
local comm = {}
local fn = vim.fn

local magic_char = { '%^', '%$', '%(', ')', '%%', '%.', '%[', '%]', '%+', '%-', '%*', '%?' }

-- get comment seperator of different filetype
local function get_sep()
  local cur_ft = vim.bo.filetype
  local sep = config[cur_ft]
  if sep == nil then
    vim.notify("Don't support this filetype. Please check your configuration.")
    return
  end

  for _, c in pairs(magic_char) do
    if sep:match(c) ~= nil then
      sep = sep:gsub(c, '%' .. c)
    end
  end

  return sep
end

-- add comment
local function add_comment(lines, min_spaces)
  local sep = get_sep() .. ' '
  local res = {}
  for _, v in pairs(lines) do
    local newline = ""
    if #v > 0 then
      newline = string.rep(' ', min_spaces) .. sep .. v:sub(min_spaces + 1)
    end
    table.insert(res, newline)
  end
  return res
end

-- cancel comment
local function cancel_comment(lines)
  local sep = get_sep() .. ' '
  local res = {}
  for _, v in pairs(lines) do
    local newline = ""
    if #v > 0 then
      newline = v:gsub(sep, '', 1)
    end
    table.insert(res, newline)
  end
  return res
end

-- generate comment
function comm.gen_comment(line_start, line_end)
  local lines = fn.getline(line_start, line_end)

  local res = {}
  local has_no_comm = false

  local min_spaces = 300
  local sep = get_sep() .. ''
  for _, v in pairs(lines) do
    if #v > 0 and v:match('^%s*' .. sep) == nil then
      has_no_comm = true
    end

    if #v > 0 then
      local _, cur_spaces = v:find('^%s*')
      min_spaces = cur_spaces < min_spaces and cur_spaces or min_spaces
    end
  end

  if has_no_comm == true then
    res = add_comment(lines, min_spaces)
  else
    res = cancel_comment(lines)
  end

  return res
end

return comm
