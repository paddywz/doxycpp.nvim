local comm = {}
local fn = vim.fn
-- add comment
local function add_comment(lines, min_spaces)
  local res = {}
  for _, v in pairs(lines) do
    local newline = ""
    if #v > 0 then
      newline = string.rep(' ', min_spaces) .. '// ' .. v:sub(min_spaces + 1)
    end
    table.insert(res, newline)
  end
  return res
end

-- cancel comment
local function cancel_comment(lines)
  local res = {}
  for _, v in pairs(lines) do
    local newline = ""
    if #v > 0 then
      newline = v:gsub('// ', '')
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
  for _, v in pairs(lines) do
    if #v > 0 and v:match('^%s*// ') == nil then
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
