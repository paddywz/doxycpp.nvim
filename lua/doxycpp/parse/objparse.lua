local M = {}

local type_tbl = { "struct", "enum", "class" }
local spaces_len = 8

function M.match(line)
  for _, v in pairs(type_tbl) do
    if line:match("^%s*" .. v) ~= nil then
      M.type = v
      M.prefix = line:match('^%s*')
      return true
    end
  end
end

function M.annotation()
  local res = {}
  table.insert(res, M.prefix .. '/** ' .. M.type)
  table.insert(res, M.prefix .. ' * @brief ' .. string.rep(' ', spaces_len))
  table.insert(res, M.prefix .. ' */')
  return res
end

return M
