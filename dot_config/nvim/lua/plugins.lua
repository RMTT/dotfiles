require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use 'luochen1990/rainbow'

    use 'shaunsingh/nord.nvim'

    use {
        'ibhagwan/fzf-lua',
        requires = {'vijaymarupudi/nvim-fzf', 'kyazdani42/nvim-web-devicons'}
    }

    use 'neovim/nvim-lspconfig'

    ---- for autocompletion ----
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    ---- for vsnip users ----
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    ---- end ----

    ---- for lua-tree ----
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    ---- end ----

    use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}

    use 'numToStr/FTerm.nvim'

    use 'tpope/vim-fugitive'

    use 'regen100/cmake-language-server'

    use 'editorconfig/editorconfig-vim'

    use {'raghur/vim-ghost', cmd = 'GhostInstall'}

    use 'bitc/vim-bad-whitespace'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }

    use {
        'vmware-tanzu/ytt.vim',
        requires = {
            'cappyzawa/starlark.vim'
        }
    }
end)

---- setting for lualine ----
require('lualine').setup {options = {icon_enabled = true, theme = 'nord'}}
---- end ----

---- setting for rainbow ----
vim.g.rainbow_active = 1
---- end ----

---- setting for nord-vim ----
vim.cmd('colorscheme nord')
vim.cmd('highlight Normal ctermbg=none guibg=none')
vim.cmd('highlight NonText ctermbg=none guibg=none')
---- end ----

---- setting for fzf-lua ----
vim.api.nvim_set_keymap('n', '<space>f',
                        "<cmd>lua require('fzf-lua').files()<CR>",
                        {noremap = true, silent = true})
---- end ----

---- setting for nvim-lspconfig ----
local lspconfig = require('lspconfig')

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
---- end ----

---- setting for nvim-cmp ----
vim.o.completeopt = 'menu,menuone,noselect'

-- Setup nvim-cmp.
local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
    }, {{name = 'buffer'}})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
---- end ----

---- config lsp server ----
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

-- pyright
lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {formatters = {yapf = {command = 'yapf'}}}
}

-- lua language server
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {'lua-language-server'}
}

---- efm support ----
-- efm is used to lint and format for some lsps which do not support such functions
lspconfig.efm.setup {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {'.git'},
        languages = {
            lua = {{formatCommand = 'lua-format -i', formatStdin = true}},
            python = {
                {formatCommand = 'yapf', formatStdin = true},
                {lintCommand = 'pylint', lintStdin = false}
            }
        }
    },
    filetypes = {'python', 'lua'}
}

require"lspconfig".efm.setup {
    filetypes = {'sh'},
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            sh = {
                {
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck',
                    lintFormats = {
                        "%f:%l:%c: %trror: %m",
                        "%f:%l:%c: %tarning: %m",
                        "%f:%l:%c: %tote: %m"
                    },
                    lintStdin = false
                }
            }
        }
    }
}
---- end ----

---- cmake ----
lspconfig.cmake.setup {on_attach=on_attach}

---- ccls ----
lspconfig.ccls.setup {on_attach = on_attach, capabilities = capabilities}
---- end ----

---- go ----
lspconfig.gopls.setup{on_attach=on_attach}
---- end ----

---- lua-tree setting ----
require('nvim-tree').setup{
    git = {
        enable = true,
        ignore = true
    }
}
vim.api.nvim_set_keymap('n', '<A-d>', '<cmd>NvimTreeToggle<CR>',
                        {silent = true, noremap = true})
---- end ----

---- FTerm setting ----
local fterm = require 'FTerm'
fterm.setup({border = 'single', dimensions = {height = 0.9, width = 0.9}})
vim.api.nvim_set_keymap('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<A-i>',
                        '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
                        {noremap = true, silent = true})
local gitui = fterm:new({
    ft = 'fterm_gitui',
    cmd = "gitui",
    dimensions = {height = 0.9, width = 0.9}
})

-- Use this to toggle gitui in a floating terminal
function _G.__fterm_gitui() gitui:toggle() end
vim.api.nvim_set_keymap('n', '<A-g>', '<cmd>lua __fterm_gitui()<CR>',
                        {silent = true, noremap = true})

local top = fterm:new({
    ft = 'fterm_top',
    cmd = "bpytop",
    dimensions = {height = 0.9, width = 0.9}
})
-- Use this to toggle btop in a floating terminal
function _G.__fterm_top() top:toggle() end
vim.api.nvim_set_keymap('n', '<A-p>', '<cmd>lua __fterm_top()<CR>',
                        {silent = true, noremap = true})
---- end ----

---- setting for gitsign ----
require('gitsigns').setup()
---- end ----
