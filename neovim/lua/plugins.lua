local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    use { 'nvim-treesitter/nvim-treesitter', 
          run = ':TSUpdate | :TSInstall c_sharp | :TSInstall bash'
    }

    use { 'nvim-telescope/telescope.nvim',
          requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'dense-analysis/ale' }
    use { 'neoclide/coc.nvim', branch = 'release' }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = { { 'kyazdani42/nvim-web-devicons' } }
    }

    use { 'mhartington/formatter.nvim' }

    require('formatter').setup({
        filetype = {
            cpp = {
                function()
                    return {
                        exe = "clang-format",
                        args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                        stdin = true,
                        cwd = vim.fn.expand('%:p:h') -- run clang-format in cwd of the file
                    }
                end
            },
        }
    })

    vim.api.nvim_exec([[
        augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost *.cpp,*.hpp,*.c,*.h,*.cc,*.hh FormatWrite
        augroup END
    ]], true)

    require('nvim-tree').setup {
        disable_netrw        = false,
        hijack_netrw         = true,
        open_on_setup        = false,
        ignore_buffer_on_setup = false,
        ignore_ft_on_setup   = {},
        auto_close           = false,
        auto_reload_on_write = true,
        open_on_tab          = false,
        hijack_cursor        = false,
        update_cwd           = false,
        hijack_unnamed_buffer_when_opening = false,
        hijack_directories   = {
            enable = true,
            auto_open = true,
        },
        diagnostics = {
            enable = false,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            }
        },
        update_focused_file = {
            enable      = false,
            update_cwd  = false,
            ignore_list = {}
        },
        system_open = {
            cmd  = nil,
            args = {}
        },
        filters = {
            dotfiles = false,
            custom = {}
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 500,
        },
        view = {
            width = 30,
            height = 30,
            hide_root_folder = false,
            side = 'left',
            preserve_window_proportions = false,
            mappings = {
                custom_only = false,
                list = {}
            },
            number = false,
            relativenumber = false,
            signcolumn = "yes"
        },
        trash = {
            cmd = "trash",
            require_confirm = true
        },
        actions = {
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
                        buftype  = { "nofile", "terminal", "help", },
                    }
                }
            }
        }
    }

    -- plugin settings
    require('telescope').load_extension('fzf')
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
            -- this are all default values
            --     fuzzy = true,
            --     override_generic_sorter = true,
            --     override_file_sorter = true,
            --     case_mode = "smart_case"
            -- }
        }
    }

    vim.cmd([[
    let g:coc_global_extensions = [
        \ 'coc-marketplace',
        \ 'coc-clangd',
        \ 'coc-cmake',
        \ 'coc-git',
        \ 'coc-lua',
        \ 'coc-omnisharp',
        \ 'coc-pyright',
        \ 'coc-json',
        \ 'coc-snippets',
        \ 'coc-sql',
        \ 'coc-xml',
        \ 'coc-vimlsp',
        \ 'coc-yaml']  ]])

    vim.cmd([[
        let ale_disable_lsp = 1
        let ale_sign_error = ''
        let ale_sign_warning = ''
        let ale_linters = { 'cpp': ['clang'], 'c':['clang'] }
    ]])

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

