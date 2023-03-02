local M = {}

function M.match(line)
  local fun_dec = line:match('^%s*[a-zA-Z_]+[a-zA-Z0-9_]* [a-zA-Z_]+[a-zA-Z0-9_]*%(.*%)')
  if fun_dec == nil then
    return
  end

  M.fun_dec = fun_dec
  M.prefix = line:match('^%s*')
  return true
end

function M.annotation()
  local fun_dec = M.fun_dec
  local prexif = M.prefix

  local ret = fun_dec:match('%w+')
  local fun_name = fun_dec:match(ret .. ' ' .. '(%w*)')
  local args = fun_dec:match('%((.+)%)')

  local res = {}
  table.insert(res, "/** function " .. fun_name)
  table.insert(res, " * @brief")

  local args_list = {}
  local max_arg_len = 0
  if args ~= nil then
    local args_tbl = vim.split(args, ',', { trimempty = true })
    for _, v in pairs(args_tbl) do
      local arg = v:match(' [*]*([a-zA-Z_]+[a-zA-Z0-9]*)') or ""
      max_arg_len = #arg > max_arg_len and #arg or max_arg_len
      table.insert(args_list, M.prefix .. ' * @param ' .. arg)
    end
  end

  for _, v in pairs(args_list) do
    table.insert(res, v .. string.rep(' ', max_arg_len + 8 - #v))
  end

  if ret ~= 'void' then
    table.insert(res, " * @return")
  end
  table.insert(res, " */")

  return res
end


return M
