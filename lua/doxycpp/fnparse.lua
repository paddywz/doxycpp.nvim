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
  table.insert(res, M.prefix .. "/** function " .. fun_name)

  local args_list = {}
  local max_arg_len = 0
  if args ~= nil then
    local args_tbl = vim.split(args, ',', { trimempty = true })
    for _, v in pairs(args_tbl) do
      v = v:gsub('^%s+', '')
      v = v:gsub('%s+$', '')
      local arg = v:match(' [*]*([a-zA-Z_]+[a-zA-Z0-9]*)') or ""
      max_arg_len = #arg > max_arg_len and #arg or max_arg_len
      table.insert(args_list, M.prefix .. ' * @param ' .. arg)
    end
  end
 
  -- set format
  local space_len = 8
  local rep_space_len = max_arg_len + string.len(' * @param ') - string.len(' * @brief ') + space_len
  table.insert(res, M.prefix .. " * @brief " .. string.rep(' ', rep_space_len))

  for _, v in pairs(args_list) do
    local arg_len = #v - string.len(' * @param ') - #M.prefix
    rep_space_len = max_arg_len + space_len - arg_len
    table.insert(res, v .. string.rep(' ', rep_space_len))
  end

  if ret ~= 'void' then
    rep_space_len = max_arg_len + string.len(' * @param ') - string.len(' * @return') + space_len
    table.insert(res, M.prefix .. " * @return" .. string.rep(' ', rep_space_len))
  end
  table.insert(res, M.prefix .. " */")

  return res
end


return M
