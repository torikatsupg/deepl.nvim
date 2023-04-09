# Deepl.nvim

![demo](docs/demo.gif)

## Install
packer.nvim
```lua
use {
    'torikatsupg/deepl.nvim',
    setup = function()
        vim.env.deepl_nvim_apikey = 'your apikey of freeplan'
        vim.keymap.set('v', '<C-t>', function()
          vim.env.deepl_nvim_apikey = 'your api key'
          require 'deepl'.translate()
        end, { noremap = true, silent = true })
    end,
    }

```
⚠️ Only support deepl freeplan  
⚠️ Only support japanese  
⚠️ You neet to configure keymap on visual mode.  

## Usage
1. select words
1. call require'deepl'.translate(), then translated text will show.
