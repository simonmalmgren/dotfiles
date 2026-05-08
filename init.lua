local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.history = 1000
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.visualbell = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.undofile = true

local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")

vim.opt.undodir = { prefix .. "/nvim/.undo//"}
vim.opt.backupdir = {prefix .. "/nvim/.backup//"}
vim.opt.directory = { prefix .. "/nvim/.swp//"}

vim.opt.signcolumn = "yes"

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wqall", "wqall", {})
vim.api.nvim_create_user_command("WQall", "wqall", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qall", "qall", {})

-- use "-" as word in html land
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css", "html", "jsx", "tsx" },
  callback=function()vim.opt_local.iskeyword:append("-")
  end,
})

require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    { "nvim-treesitter/nvim-treesitter", tag = "v0.10.0", lazy = false, build = ":TSUpdate" },
    {
      "ibhagwan/fzf-lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {
        files = {
          no_ignore = false,
        },
      }
    },
    "tpope/vim-fugitive",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    {"mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    }},
    "neovim/nvim-lspconfig",
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
})

vim.cmd[[colorscheme tokyonight]]

require("fzf-lua").setup({"fzf-vim"})

vim.keymap.set("n", "<leader>f", require("fzf-lua").files, { desc = "Files" })
vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "Buffers" })

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls" }
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  end,
})

local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-o>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
})
