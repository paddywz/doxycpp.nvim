local comm = {}
local fn = vim.fn
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

-- generate comment
function comm.gen_comment(line_start, line_end)
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

return comm
