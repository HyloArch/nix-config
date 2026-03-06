{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      lua-language-server
      nil
      rust-analyzer
      clang-tools
      typescript-language-server
      java-language-server
      stylua
      nixd
    ];
    programs = {
      ripgrep.enable = true;
      neovim = {
        enable = true;
        extraConfig = ''
          set expandtab
          set tabstop=2
          set softtabstop=2
          set shiftwidth=2
          set winborder=rounded
          let g:mapleader=" "
        '';
        extraLuaConfig = ''
          vim.opt.number = true
          vim.opt.relativenumber = false
          vim.diagnostic.config({
            underline = true;
            virtual_text = true;
            update_in_insert = true;
            severity_sort = true;
          })
        '';
        plugins = with pkgs.vimPlugins; [
          {
            plugin = catppuccin-nvim;
            config = "colorscheme catppuccin";
          }
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              require("lualine").setup({
                options = {
                  theme = 'dracula'
                }
              })
            '';
          }
          {
            plugin = telescope-nvim;
            type = "lua";
            config = ''
              local builtin = require("telescope.builtin")
              vim.keymap.set("n", "<C-p>", builtin.find_files)
              vim.keymap.set("n", "<leader>fg", builtin.live_grep)
            '';
          }
          {
            plugin = telescope-ui-select-nvim;
            type = "lua";
            config = ''
              require("telescope").setup({
                extensions = {
                  ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                  }
                }
              })
              require("telescope").load_extension("ui-select")
            '';
          }
          {
            plugin = nvim-treesitter;
            type = "lua";
            config = ''
              require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true }
              })
            '';
          }
          {
            plugin = neo-tree-nvim;
            type = "lua";
            config = ''
              vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>")
              vim.keymap.set("n", "<leader>m", ":Neotree git_status reveal left<CR>")
              vim.keymap.set("n", "<leader>b", ":Neotree buffers float<CR>")
            '';
          }
          nvim-web-devicons
          {
            plugin = nvim-lspconfig;
            type = "lua";
            config = ''
              local capabilities = require("cmp_nvim_lsp").default_capabilities()
              local lsps = { "lua_ls", "nil_ls", "nixd", "rust_analyzer", "clangd", "ts_ls", "java_language_server" }
              for _, lsp in ipairs(lsps) do
                vim.lsp.config(lsp, {
                  capabilities = capabilities
                })
              end
              vim.lsp.enable(lsps)

              vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
              vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            '';
          }
          {
            plugin = none-ls-nvim;
            type = "lua";
            config = ''
              local null_ls = require("null-ls")

              null_ls.setup({
                sources = {
                  null_ls.builtins.formatting.stylua
                }
              })

              vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
            '';
          }
          luasnip
          cmp_luasnip
          friendly-snippets
          cmp-nvim-lsp
          {
            plugin = nvim-cmp;
            type = "lua";
            config = ''
              local cmp = require("cmp")
              require("luasnip.loaders.from_vscode").lazy_load()

              cmp.setup({
                snippet = {
                  expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                  end,
                },
                window = {
                  completion = cmp.config.window.bordered(),
                  documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                  ["<C-f>"] = cmp.mapping.scroll_docs(4),
                  ["<C-Space>"] = cmp.mapping.complete(),
                  ["<C-e>"] = cmp.mapping.abort(),
                  ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                }, {
                  { name = "buffer" },
                }),
              })
            '';
          }
          # {
          #   plugin = trouble-nvim;
          #   type = "lua";
          #   config = ''
          #     require("trouble").setup({})
          #   '';
          # }
        ];
      };
    };
    home.sessionVariables.EDITOR = "nvim";
  };
}
