local objparse = require('doxycpp.parse.objparse')
local fnparse = require('doxycpp.parse.fnparse')

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
      if vim.bo.filetype ~= 'cpp' then
        vim.notify("Annotation only works for cpp now.")
        return
      end
      return p.annotation()
    end
  end
end

-- parse struct class enum
annotation:register(objparse)
-- parse function
annotation:register(fnparse)

setmetatable(M, annotation)

return M
