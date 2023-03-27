# Deepl.nvim
## Install
packer.nvim
```lua
use {
    'torikatsupg/deepl.nvim',
    setup = function()
        vim.env.deepl_nvim_apikey = 'your apikey of freeplan'
        vim.keymap.set('v', '<C-t>', function()
          vim.env.deepl_nvim_apikey = 'db8a1695-bfa9-3f70-99e4-44897f131e54:fx'
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
