-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
  keys = {
    "ga", -- Default invocation prefix
    { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    "Subs",
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
  -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
  -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
  -- available after the first executing of it or after a keymap of text-case.nvim has been used.
  lazy = false,
},
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    -- optional = false,
    config = function()
      local conform = require('conform')
      conform.setup({
        formatters_by_ft = {
          javascript = { { 'prettier', 'prettierd' } },
          typescript = { { 'prettier', 'prettierd' } },
          typescriptreact = { { 'prettier', 'prettierd' } },
          json = { 'prettier' },
          css = { 'prettier' },
          scss = { 'prettier' },
          -- html = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          graphql = { 'prettier' },
          lua = { 'stylua' },
          ejs = { { 'prettier', 'prettierd' } },
          html = { { 'prettier', 'prettierd' } },
        },
        -- formatters = {
        --   prettier = {
        --     -- exclude the repo /Users/danielmaizel/codefresh/argo-platform
        --     -- condition = function(ctx)
        --     --   return vim.fs.find({ 'argo-platform' }, { path = ctx.filename, upward = true })[1]
        --     -- end,
        --   },
        -- },
        format_on_save = {
          lsp_fallback = false,
          async = false,
          timeout_ms = 1500,
        },
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
        print('format before')
        conform.format { lsp_fallback = true, async = false, timeout_ms = 500 }
        print('format after')
      end, { desc = 'Format file or range (in visual mode)' })
    end,
    -- lazy = false
  },
  { 'ThePrimeagen/vim-be-good',     lazy = false },
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } },
  },
  { 'ThePrimeagen/refactoring.nvim' },
  { 'FabijanZulj/blame.nvim',       lazy = false },
  {
    'NVChad/nvim-colorizer.lua',
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,          -- #RGB hex codes
        RRGGBB = true,       -- #RRGGBB hex codes
        names = true,        -- "Name" codes like Blue or blue
        RRGGBBAA = false,    -- #RRGGBBAA hex codes
        AARRGGBB = false,    -- 0xAARRGGBB hex codes
        rgb_fn = false,      -- CSS rgb() and rgba() functions
        hsl_fn = false,      -- CSS hsl() and hsla() functions
        css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false,                                -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    }
  },
  { 'olimorris/onedarkpro.nvim' , priority= 1000, lazy=false},
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    opts = {},
    keys = { { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' } },
    config = function()
      require('diffview').setup()
      vim.keymap.set('n', '<leader>gd', function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd 'DiffviewOpen'
        else
          vim.cmd 'DiffviewClose'
        end
      end)
    end,
  },
  -- { 'mrcjkb/rustaceanvim' },
  {
    'kdheepak/lazygit.nvim',
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
  },
  { 'nvim-tree/nvim-web-devicons' },
  { 'MunifTanjim/nui.nvim' },
  { 'folke/lsp-colors.nvim' },
  { 'folke/trouble.nvim' },
  { 'aznhe21/actions-preview.nvim' },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<leader>x<space>",
        function()
          -- print(vim.fs.dirname(vim.fs.find('.git', { upward = true })
          --     [1]))

          require("neo-tree.command").execute({
            position="float",
            toggle = true,
            reveal_file = vim.api.nvim_buf_get_name(0),
            -- dir = vim.fn.expand('%:h')
          })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>xE",
        function()
          require("neo-tree.command").execute({ position="float", toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>xg",
        function()
          require("neo-tree.command").execute({position="float", source = "git_status", toggle = true })
        end,
        desc = "Git explorer",
      },
      {
        "<leader>xb",
        function()
          require("neo-tree.command").execute({position="float", source = "buffers", toggle = true })
        end,
        desc = "Buffer explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    config = function(_, opts)
      -- from lazyvim
      function get_clients(opts)
        local ret = {} ---@type lsp.Client[]
        if vim.lsp.get_clients then
          ret = vim.lsp.get_clients(opts)
        else
          ---@diagnostic disable-next-line: deprecated
          ret = vim.lsp.get_active_clients(opts)
          if opts and opts.method then
            ---@param client lsp.Client
            ret = vim.tbl_filter(function(client)
              return client.supports_method(opts.method, { bufnr = opts.bufnr })
            end, ret)
          end
        end
        return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
      end

      function on_rename(from, to)
        local clients = get_clients()
        for _, client in ipairs(clients) do
          if client.supports_method("workspace/willRenameFiles") then
            ---@diagnostic disable-next-line: invisible
            local resp = client.request_sync("workspace/willRenameFiles", {
              files = {
                {
                  oldUri = vim.uri_from_fname(from),
                  newUri = vim.uri_from_fname(to),
                },
              },
            }, 1000, 0)
            if resp and resp.result ~= nil then
              vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
            end
          end
        end
      end

      local function on_move(data)
        on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

}
