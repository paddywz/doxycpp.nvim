# doxycpp.nvim
🎉🎉A simple and useful plugin to generate doxygen style annotation and comment for cpp more easily.🎉🎉

![doxycpp_one](https://user-images.githubusercontent.com/101847923/222450881-f472a55e-4c09-4a55-8798-c0b6feb98259.gif)

# Features
- 🚀Fast
- ❄️Minimalist and light weight
- 🎈Independent, not depends on any third-party plugins
- ✨comment or cancel comment for the code selected when in visual mode
- 🧨generate doxygen style annotations when the cursor is on the first line of function declaration, class's, etc.

# Install
- lazy.nvim
``` lua
require('lazy').setup({
  { 'paddywz/doxycpp.nvim', ft = { your filetype }, config = function
    require('doxycpp').setup()
  end},
})
```
- packer.nvim
``` lua
use({
  { 'paddywz/doxycpp.nvim', ft = { your filetype }, config = function
    require('doxycpp').setup()
  end},
})
```
# Cofiguration
### default configuration
```lua
{
  comment = {
    ['c'] = '//',
    ['cpp'] = '//',
    ['lua'] = '--',
    ['python'] = '#',
    ['cmake'] = '#',
  }
}
```
### custom your comment symbol
the key in table comment is filetype, value is your custom comment symbol
```
require('doxycpp').setup({
  comment = {
    ['java'] = '//',
  }
})
```

# Keymap
```lua
vim.api.nvim_set_keymap('n', 'gcc', '<cmd>Doxycpp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'gcc', '<cmd>Doxycpp<CR', { noremap = true, silent = true })
```

# Show
<details>
<summary>comment showcase</summary>

![doxycpp_two](https://user-images.githubusercontent.com/101847923/223134410-653a388d-9d36-42cb-820c-bb11fedf0989.gif)

</details>

<details>
<summary>annotation showcase</summary>

![doxycpp_three](https://user-images.githubusercontent.com/101847923/223135266-3de3921b-3e37-4d31-b429-47d2ee6af7bb.gif)
</details>

# ToDo
- 🌟make it work when the function declaration is crrosing multiple lines.

# Note
- 🌒Don't work on constructor function unfortunately. But I think we don't need to annotate ctor most of the time.

# License MIT

