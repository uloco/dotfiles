" Plugins
"------------------------------------------------------------------------------
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

" Colors
Plug 'uloco/vim-bluloco-dark'
Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'
Plug 'dracula/vim'

" Git
Plug 'airblade/vim-gitgutter'
let g:gitgutter_signs = 1
let g:gitgutter_grep = 'ag'
" Always show signcolumn
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Linting
Plug 'w0rp/ale'
" let g:ale_completion_enabled = 1

" LSP
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

let g:LanguageClient_serverCommands = {
      \ 'typescript': ['typescript-language-server', '--stdio'],
      \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

if has_key(g:LanguageClient_serverCommands, &filetype)
  nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
endif

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Interface
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline' " status bar

Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='deus'
let g:airline_powerline_fonts=1
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons' " icons for nerd-tree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Stuff
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-highlightedyank'
Plug 'padde/jump.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Languages
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1
" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'curist/vim-angular-template'

call plug#end()

"" General settings
"------------------------------------------------------------------------------
syntax on
set nu
set backspace=indent,eol,start
set hlsearch
set ignorecase
set smartcase
set splitright
set splitbelow
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
set hidden
set undofile
set undodir=$HOME/.config/nvim/.vimundo
set colorcolumn=80
set textwidth=80
set background=dark
set conceallevel=0
set wildmenu
set wildmode=longest:full,full

" External vimrc files
set exrc
set secure

" Indentation of 2 spaces
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Completion
filetype plugin on
" set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Enable mouse
set mouse=a

" New Tab with ctrl-w + t
nnoremap <A-t> :tabnew<CR>

" Terminal Mode Mappings
tnoremap <Esc> <C-\><C-n>

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <leader>hi :nohlsearch<CR>

" Change current working directory to file location
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Reload .vimrc file
nnoremap <leader>so :so ~/.vimrc<CR>

" Often used shortcuts
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>a :wa<CR>

" Split nav
nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>
inoremap <A-j> <Esc><C-W><C-J>
inoremap <A-k> <Esc><C-W><C-K>
inoremap <A-l> <Esc><C-W><C-L>
inoremap <A-h> <Esc><C-W><C-H>
tnoremap <A-j> <C-\><C-n><C-W><C-J>
tnoremap <A-k> <C-\><C-n><C-W><C-K>
tnoremap <A-l> <C-\><C-n><C-W><C-L>
tnoremap <A-h> <C-\><C-n><C-W><C-H>

" Split resizing
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Switch between different file extensions
map <A-u> :e %:r.ts <CR>
map <A-i> :e %:r.scss <CR>
map <A-o> :e %:r.html <CR>
map <A-d> :e %:r.spec.ts <CR>

" Tab nav
nnoremap <C-j> gT
nnoremap <C-k> gt

" Format file
map <leader>l mzgg=G`zzz

" fzf Fuzzy search mappings
map <silent> <C-P> :Files<CR>
map <silent> <leader>pf :Ag<CR>
map <silent> <leader>pg :GFiles?<CR>
map <silent> <leader>pb :Buffers<CR>
map <silent> <leader>pw :Windows<CR>
map <silent> <leader>ps :Snippets<CR>
map <silent> <leader>pc :Commits<CR>

" NERDTree
map <leader>b :NERDTreeToggle<CR>

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
nmap <leader>o :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Search after visual selected text with //
vnoremap // y/<C-R>"<CR>

colorscheme bluloco-dark
