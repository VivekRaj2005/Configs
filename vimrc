"Options"
syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set ignorecase
set smartcase
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch 
set signcolumn=yes
set splitbelow
set splitright
set laststatus=2
set noshowmode
set nowrap
set ttymouse=sgr                                        "Only For Alacritty Users"
set encoding=UTF-8

"Plugins"
call plug#begin('~/.vim/plugged')
Plug 'gabrielelana/vim-markdown'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'https://github.com/mbbill/undotree.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'frazrepo/vim-rainbow'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'https://github.com/sainnhe/sonokai.git'
call plug#end()

"Color Scheme" 
colorscheme sonokai
set background=dark

"Keycodes"
let mapleader=" "
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>z :UndotreeShow<CR>
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>p :Prettier<CR>
nnoremap <leader>gt :YcmCompleter GoToDeclaration<CR>

"Nerdtree Options"
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"Lightline"
if !has('gui_running')
  set t_Co=256
endif

"Synastic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Emmet"
let g:user_emmet_mode='a' 
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-e>'
autocmd FileType html,css EmmetInstall

"Rainbow Brackets"
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

"Prettier"
let g:prettier#exec_cmd_async = 1
let g:prettier#config#print_width = 'auto'
let g:prettier#config#tab_width = '4'
let g:prettier#config#use_tabs = 'auto'
let g:prettier#config#parser = ''
let g:prettier#config#config_precedence = 'file-override'
let g:prettier#config#prose_wrap = 'preserve'
let g:prettier#config#html_whitespace_sensitivity = 'css'
let g:prettier#config#require_pragma = 'false'
let g:prettier#config#end_of_line = get(g:, 'prettier#config#end_of_line', 'lf')

"Markdown Settings"
let g:markdown_include_jekyll_support = 1
let g:markdown_enable_folding = 0
let g:markdown_enable_spell_checking = 1
let g:markdown_enable_input_abbreviations = 1

"Nerdtree"
let g:NERDTreeShowHidden=1
