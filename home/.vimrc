set number
nnoremap ]c j]cztk

" install vim-plug https://github.com/junegunn/vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" setup vim-plug plugins
call plug#begin()
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'axelf4/vim-strip-trailing-whitespace'
" Run :PlugInstall to install new plugins after you've added
call plug#end()
