{ pkgs, config, ... }:{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  
    extraPackages = with pkgs; [
      lua
      clang-tools
      ripgrep # For :Telescope live_grep
      xclip # For clipboard support
    ];
    plugins = with pkgs.vimPlugins; [
      vim-nix 
      copilot-vim
      vim-colors-solarized

      {
        plugin = catppuccin-nvim;
        config = ''
          lua << EOF
            vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
            require('catppuccin').setup {
              styles = {
                functions = "italic",
                keywords = "italic",
                variables = "italic",
              },
            }
          EOF
        '';
      }
      {
        plugin = telescope-nvim;
        config = ''
          nnoremap <silent> tg :Telescope live_grep<CR>
          nnoremap <silent> tk :Telescope find_files<CR>
        '';
      }
      nvim-web-devicons
      {
        # Buffer management with nice looking tabs
        plugin = barbar-nvim;
        config = ''
          let bufferline = get(g:, 'bufferline', {})
          let bufferline.animation = v:false
          let bufferline.icons = v:false
          nnoremap <silent> <s-f> :BufferPick<CR>
          nnoremap <silent> fw :BufferClose<CR>
          nnoremap <silent> fl :BufferNext<CR>
          nnoremap <silent> fh :BufferPrevious<CR>
          nnoremap <silent> fml :BufferMoveNext<CR>
          nnoremap <silent> fmh :BufferMovePrevious<CR>
        '';
      }
    ];
    coc = {
      enable = true;

      package = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "coc.nvim";
        version = "2022-05-21";

        src = pkgs.fetchFromGitHub {
          owner = "neoclide";
          repo = "coc.nvim";
          rev = "791c9f673b882768486450e73d8bda10e391401d";
          sha256 = "sha256-MobgwhFQ1Ld7pFknsurSFAsN5v+vGbEFojTAYD/kI9c=";
        };
      };

      settings = {
        client.snippetSupport = true;

        suggest = {
          enablePreview = true;
          noselect = true;
          enablePreselect = false;
        };

        languageserver = {
          nix = {
            command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
            filetypes = [ "nix" ];
            rootPatterns = [
              "flake.lock"
              ".git"
            ];
          };

          clangd = {
            command = "${pkgs.clang-tools}/bin/clangd";
            compilationDatabasePath = "build/compile_commands.json";

            extraArgs = [
              "--background-index"
            ];

            filetypes = [
              "c"
              "cpp"
              "objc"
              "objcpp"
            ];

            rootPatterns = [
              "CMakeLists.txt"
              "build"
              "src"
            ];
          };
        };
      };
    };
    extraConfig = ''
      set mouse=""
      set number relativenumber
      set tabstop=2 expandtab shiftwidth=2
      set clipboard+=unnamedplus
      set makeprg=ninja

      tnoremap <A-h> <C-\><C-N><C-w>h
      tnoremap <A-j> <C-\><C-N><C-w>j
      tnoremap <A-k> <C-\><C-N><C-w>k
      tnoremap <A-l> <C-\><C-N><C-w>l
      inoremap <A-h> <C-\><C-N><C-w>h
      inoremap <A-j> <C-\><C-N><C-w>j
      inoremap <A-k> <C-\><C-N><C-w>k
      inoremap <A-l> <C-\><C-N><C-w>l
      nnoremap <A-h> <C-w>h
      nnoremap <A-j> <C-w>j
      nnoremap <A-k> <C-w>k
      nnoremap <A-l> <C-w>l

      syntax enable
      colorscheme catppuccin
      set cursorline
      set termguicolors
      set noshowmode

    '';
};
}
