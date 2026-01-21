-- ~/.config/nvim/init.lua
-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.laststatus = 2
vim.opt.completeopt = {"menu", "noselect"}
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"


-- Key mappings
vim.g.mapleader = "\\" -- Set leader key (adjust if you use different leader)

-- Movement mappings
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Custom commands
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})

-- Leader key mappings
vim.keymap.set("n", "<leader>b", "obreakpoint()<Esc>")
vim.keymap.set({"n", "i"}, "<leader>s", "<cmd>update<cr>")
vim.keymap.set({"n", "i"}, "<leader>e", "<cmd>edit!<cr>")
vim.keymap.set({"n", "i"}, "<leader>q", "<cmd>q<cr>")
vim.keymap.set({"n", "i"}, "<leader>v", "<cmd>noh<cr>")

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "css", "scss"},
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})


-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin configuration
require("lazy").setup({
  -- File explorer (modern alternative to NERDTree) - NO ICONS
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        filters = {
          dotfiles = false,
        },
      })
      vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
    end
  },

  -- Fuzzy finder (modern FZF integration) - NO ICONS
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      
      telescope.setup({
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden"},
          },
        },
      })
      
      -- FZF-like mappings
      vim.keymap.set("n", "<leader>f", builtin.find_files)
      vim.keymap.set("n", "<leader>F", builtin.find_files)
      vim.keymap.set("n", "<leader>r", builtin.live_grep)
      vim.keymap.set("n", "<leader>t", builtin.grep_string)
    end
  },

  -- LSP Configuration (replaces CoC)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- Mason setup (automatic LSP server management)
      require("mason").setup({
      })
      require("mason-lspconfig").setup({
        ensure_installed = {"pyright", "gopls", "ts_ls", "elixirls"},
      })

      -- Completion setup - NO ICONS
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {"i", "s"}),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({select = true}),
        }),
        sources = cmp.config.sources({
          {name = "nvim_lsp"},
          {name = "luasnip"},
        }, {
          {name = "buffer"},
          {name = "path"},
        })
      })

      -- LSP server configurations
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Python
      lspconfig.pyright.setup({capabilities = capabilities})
      
      -- Go
      lspconfig.gopls.setup({capabilities = capabilities})
      
      -- JavaScript/TypeScript
      lspconfig.ts_ls.setup({capabilities = capabilities})

      -- Elixir
      lspconfig.elixirls.setup({
        capabilities = capabilities,
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls") }
      })

      vim.diagnostic.config({
        virtual_text = false,  -- shows the message at the end of the line
        float = { border = "rounded" },
      })

      -- LSP key mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = {buffer = ev.buf}
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<F5>", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<F8>",  vim.diagnostic.setloclist)
          vim.keymap.set("n", "vd", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
          end, opts)
        end,
      })
    end
  },

  -- Statusline (modern alternative to lightline) - NO ICONS
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  },

  -- Other essential plugins
  "tpope/vim-surround",
  {
     "numToStr/Comment.nvim",
     config = function()
       require("Comment").setup({
         toggler = { line = "<leader>c" },   -- NORMAL: <leader>c toggles the current line
         opleader = { line = "<leader>c" },  -- VISUAL/OPERATOR: <leader>c toggles selection or motions
       })
     end,
  },
  "christoomey/vim-tmux-navigator",
  "tpope/vim-fugitive",

  -- Syntax highlighting (Treesitter is preferred over vim-polyglot)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {"python", "go", "javascript", "typescript", "lua", "css", "html", "elixir", "heex"},
        highlight = {enable = true},
        indent = {enable = true},
      })
    end
  },
})
