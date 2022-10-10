-- Load Packer
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Load essential plugins
  use 'tpope/vim-commentary'
  use 'editorconfig/editorconfig-vim'
  use 'nathanaelkane/vim-indent-guides'
  use 'bronson/vim-trailing-whitespace'
  use 'andymass/vim-matchup'

  -- Required for <F5> for compile & run
  use 'tpope/vim-dispatch'

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'}
  }

  -- Colorscheme
  use 'marko-cerovac/material.nvim'
  vim.cmd 'colorscheme material'

  -- Statusline at the bottom
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = {},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff'},
      lualine_c = {'filename'},
      lualine_x = {'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 4, -- 4: Shows buffer name + buffer number
        }
      }
    },
    winbar = {},
    inactive_winbar = {},
    extensions = {'nvim-tree'}
  }

  -- See commit messages
  use 'rhysd/git-messenger.vim'

  -- Git status signs
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        current_line_blame = false
      })
    end
  }

end)
