{ pkgs, config, ...}:

{
  # Configure emacs version & packages, point to init.el
  programs.neovim = {
    enable = true;
    extraLuaConfig = builtins.readFile ./init.lua;
    plugins = with pkgs.vimPlugins; [
      gruvbox-nvim
      nvim-treesitter
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
        [ p.lua
          p.nix
          p.python
          p.bash
          # p.c
          # p.java
        ]))
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      vim-fugitive
      vim-sleuth
      nvim-lspconfig
      neodev-nvim
      fidget-nvim
      gitsigns-nvim
      lualine-nvim
      nvim-cmp
      luasnip
      cmp_luasnip
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-spell
      friendly-snippets
      indent-blankline-nvim

      # neogit
      # maybes...
      #   vim-addon-nix
      #   dashboard-nvim
      #   (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      
      #   cmp-treesitter
      #   onedark-nvim
      #   neoformat
      #   vim-nix
      #   barbar-nvim
      #   nvim-web-devicons
      #   vim-airline
      #   vim-ccls
      #   vim-airline-themes
      #   nvim-autopairs
      #   neorg
      #   vim-markdown
      #   rust-tools-nvim
      #   lspkind-nvim
    ];
    extraPackages = with pkgs; [
      # Ripgrep for telescope
      ripgrep
      # Language servers
      rnix-lsp
    ];
  };

    # Install neovide GUI
    home.packages = with pkgs; [
      neovide
    ];


}
