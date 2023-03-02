local M = {}

local type_tbl = { "struct", "enum", "class" }

function M.match(line)
  for _, v in pairs(type_tbl) do
    if line:match("^%s*" .. v) ~= nil then
      M.type = v
      return true
    end
  end
end

function M.annotation()
  local res = {}
  table.insert(res, '/** ' .. M.type)
  table.insert(res, '/* @brief      ')
  table.insert(res, '**/')
  return res
end

return M
