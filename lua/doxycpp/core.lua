local objparse = require('doxycpp.objparse')

local M = {}

local doxycpp = {}

doxycpp.__index = doxycpp

function doxycpp.__newindex(table, key, val)
  if doxycpp[key] ~= nil then
    return
  end
  rawset(table, key, val);
end

function doxycpp:register(parse)
  if self.handler == nil then
    self.handler = {}
  end
  table.insert(self.handler, parse)
end

function doxycpp.annotacomment(line)
  for _, p in pairs(doxycpp.handler) do
    if p.match(line) == true then
      return p.annotation()
    end
  end
end

-- parse struct class enum
doxycpp:register(objparse)

setmetatable(M, doxycpp)

return M
