local M = {}

M.config = {
  comment = {
    ['c'] = '//',
    ['cpp'] = '//',
    ['lua'] = '%-%-',
    ['cmake'] = '#',
    ['python'] = '#',
  }
}

function M:init(opts)
  self.config = vim.tbl_deep_extend('force', self.config, opts or {})
end

return M
