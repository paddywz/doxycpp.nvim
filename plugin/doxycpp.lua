local api = vim.api
local doxycpp = require('doxycpp')

-- create command
local group = api.nvim_create_augroup("DoxyCpp", {clear = true})

api.nvim_create_autocmd("filetype", {
  group = group,
  callback = function()
    api.nvim_create_user_command("DoxyCpp", function()
      doxycpp:gen_annoment()
    end, {})
  end
})
