{ pkgs, config, ... }:{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix 
    ];

    extraConfig = ''
      set mouse=""
      set number relativenumber
      set tabstop=2 expandtab shiftwidth=2
      set clipboard+=unnamedplus

      nnoremap <A-h> <C-w>h
      nnoremap <A-j> <C-w>j
      nnoremap <A-k> <C-w>k
      nnoremap <A-l> <C-w>l

      syntax enable
      set cursorline
      set noshowmode
      set background=light
      colorscheme default
    '';
};
}
