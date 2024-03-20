# Matty Ernst's Neovim Config

## Getting Started

You can start using this config by installing [Neovim](https://neovim.io/) on your machine.

Once installed, you can clone this repo under `~/.config` and then change the name of this repo from neovimrc to nvim - `mv neovimrc nvim`.
This is the default location of where nvim will look for loading configurations. Once done, go ahead and start neovim with `nvim .`. You should
see neovim start to install the plugins for this configurations. Once complete, you can quit neovim with `:qwa` (yes I just showed you how to quit vim) and 
neovim will reload with the plugins added!

Oh also, to see all the cool glyphs/icons, I use which can be downloaded [here](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip).

### Neovim is 🔥🔥🔥

If you're new, some great plugins to checkout are... 
- [telescope](lua/plugins/telescope.lua), which can quickly search your project files
and grep your files as well. 
- [neotree](lua/plugins/neotree.lua), is great for seeing your files and adjusting them. 
- [undotree](lua/plugins/undotree.lua) is
like a git history of a specific files changes that can be easily previewed.

There are a ton more all under the [plugins](lua/plugins) directory. You can look at these files and see the remaps to use these plugins.

Have fun! 😊

