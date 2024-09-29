### Nvim


##### The right place for the config

Keep all dotfiles in this repo and just link them out to the config directories where they are needed.
Make sure there is either a `init.vim` or a `init.lua` file at a time and not both.

```bash
# Link init.lua config and directories
ln -s init.lua ~/.config/nvim/init.lua
ln -s lua ~/.config/nvim/lua

# Make a backup of init.vim
mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak
```
