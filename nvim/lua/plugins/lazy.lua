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


-- Setup lazy.nvim
require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- init.lua:
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
          dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            "nvim-tree/nvim-tree.lua",
            version = "*",
            lazy = false,
            requires = {
              "nvim-tree/nvim-web-devicons",
            },
            config = function()
                require("nvim-tree").setup {
                  sort = { sorter = "case_sensitive" },
                  view = {
                    width = 30,
                    adaptive_size = true,
                  },
                  renderer = { group_empty = true },
                  filters = { dotfiles = false },
                }
              end,
          },

          {'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons'},

          {
            'terrortylor/nvim-comment',
            dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
            config = function()
              require("nvim_comment").setup({
                create_mappings = false,
                hook = function()
                  if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
                    vim.api.nvim_buf_set_option(0, "commentstring", "<!-- %s -->") -- hack for now
                    -- require("ts_context_commentstring.internal").update_commentstring() -- this should work, but it doesnt. god damn
                  end
                end
              })
            end
          }


})