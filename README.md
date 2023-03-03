# doxycpp.nvim
🎉🎉A sample and useful plugin to generate doxygen style annotation and comment for cpp more easy.🎉🎉

![doxycpp_one](https://user-images.githubusercontent.com/101847923/222450881-f472a55e-4c09-4a55-8798-c0b6feb98259.gif)

# Features
- 🚀Fast
- ❄️Minimalist and light weight
- ✨comment or cancel comment for the code selected when in visual mode
- 🧨generate doxygen style annotations when the cursor is on the first line of function declaration, class's, etc.

# Install
- lazy.nvim
``` lua
require('lazy').setup({
  { 'paddywz/doxycpp.nvim', ft = 'cpp', config = function
    require('doxycpp').setup()
  end},
})
```
- packer.nvim
``` lua
use({
  { 'paddywz/doxycpp.nvim', ft = 'cpp', config = function
    require('doxycpp').setup()
  end},
})
```
# Config
Don't need to configurate currently.

# Keymap
```lua
vim.api.nvim_set_keymap('n', 'gcc', '<cmd>Doxycpp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'gcc', '<cmd>Doxycpp<CR>', { noremap = true, silent = true })
```

# Show
## visual mode
![doxycpp_two](https://user-images.githubusercontent.com/101847923/222457788-60f356b3-e3e2-43c4-ac1a-44371a876088.gif)
# normal mode
![doxycpp_three](https://user-images.githubusercontent.com/101847923/222458974-bb99d44d-f129-4f3f-9445-665b41d7baa8.gif)

# ToDo
- 🌟make it work when the function declaration is crrosing multiple lines.

# Note
- 🌒Don't work on constructor function unfortunately. But I think we don't need to annotate ctor most of the time.

# License MIT

