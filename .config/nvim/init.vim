"" General settings
"---------------------------------------------------------------------------------
syntax on
set nu
set backspace=indent,eol,start
set hlsearch
set ignorecase
set smartcase
set splitright
set splitbelow
colorscheme bluloco-dark
set number relativenumber
let g:netrw_bufsettings="rnu"
set termguicolors
set textwidth=80
set breakindent
let showbreak='↪ '
let mapleader="\<space>"
set wrap
set cpo=n
set foldmethod=syntax
set foldlevelstart=99

" External vimrc files
set exrc
set secure

" Indentation of 2 spaces
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Enable mouse
set mouse=a

" New Tab with ctrl-w + t
:nnoremap <C-w>t :tabnew<CR>

" Terminal Mode Mappings
:tnoremap <Esc> <C-\><C-n>

" Press Space to turn off highlighting and clear any message already displayed.
" :nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" :nnoremap <silent> <leader>h :nohlsearch<Bar>:echo<CR>
:nnoremap <silent> <leader>hi :nohlsearch<CR>

" Format file
map <leader>l mzgg=G`zzz

" Normal line numbers when on insert mode or lost focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Use macros on all visual lines
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Search after visual selected text with //
vnoremap // y/<C-R>"<CR>

" Plugins
"---------------------------------------------------------------------------------
" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs' " auto adds closing brackets etc.

Plug 'airblade/vim-gitgutter'
let g:gitgutter_signs = 1
let g:gitgutter_grep = 'ag'
" Always show signcolumn
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

Plug 'scrooloose/nerdcommenter'
Plug 'machakann/vim-highlightedyank'
Plug 'w0rp/ale'

call plug#end()
