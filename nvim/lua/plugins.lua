local fn = vim.fn

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Packer not found!")
  return
end


-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Packer
  use "wbthomason/packer.nvim"

  -- git plugin
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

  -- Navigation
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  use {
    'nvim-lualine/lualine.nvim',                     -- statusline
    requires = {'kyazdani42/nvim-web-devicons',
                opt = true}
  }


  -- Colors
  use 'lifepillar/vim-solarized8'

  --- LSP
  use 'neovim/nvim-lspconfig'  -- Helper for easy start LSP configuration
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
	
  use 'Alloyed/lua-lsp' -- Lya
  use 'python-lsp/python-lsp-server' -- Python


end)
