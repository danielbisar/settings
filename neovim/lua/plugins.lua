local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate | :TSInstall c_sharp | :TSInstall bash'
  }

  use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  require('telescope').setup{
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- ..
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
         -- fzf = {
         --     fuzzy = true,
         --     override_generic_sorter = true,
         --     override_file_sorter = true,
         --     case_mode = "smart_case"
         -- }
      }
    }

  require('telescope').load_extension('fzf')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
