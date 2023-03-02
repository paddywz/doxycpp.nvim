local objparse = require('doxycpp.objparse')
local fnparse = require('doxycpp.fnparse')

local annotation = {}
local M = {}

annotation.__index = annotation

function annotation.__newindex(table, key, val)
  if annotation[key] ~= nil then
    return
  end
  rawset(table, key, val);
end

function annotation:register(parse)
  if self.handler == nil then
    self.handler = {}
  end
  table.insert(self.handler, parse)
end

function annotation.annotacomment(line)
  for _, p in pairs(annotation.handler) do
    if p.match(line) == true then
      return p.annotation()
    end
  end
end

-- parse struct class enum
annotation:register(objparse)
annotation:register(fnparse)

setmetatable(M, annotation)

return M
