local M = {}

local default_config = {
  comment = {
    ['c'] = '//',
    ['cpp'] = '//',
    ['lua'] = '--',
    ['cmake'] = '#',
    ['python'] = '#',
  }
}

function M:init(opts)
  self.config = vim.tbl_deep_extend('force', default_config, opts or {})
end

return M
