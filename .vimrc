set shell=bash            " plugin compatibility since I'm using zshell

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'fatih/vim-go'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'jamessan/vim-gnupg'
Plug 'flazz/vim-colorschemes'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nvie/vim-flake8'
Plug 'mxw/vim-jsx'
Plug 'hail2u/vim-css3-syntax'
Plug 'JulesWang/css.vim'
Plug 'miripiruni/vim-better-css-indent'
Plug 'gabrielelana/vim-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'rodjek/vim-puppet'
Plug 'vim-scripts/svnj.vim'
Plug 'Heorhiy/VisualStudioDark.vim'
Plug 'skielbasa/vim-material-monokai'
Plug 'vim-airline/vim-airline'
call plug#end()

set number
set encoding=utf-8

set directory=$HOME/.vim/tmp/swaps/
set backupdir=$HOME/.vim/tmp/backups/
set undodir=$HOME/.vim/tmp/undos/
set undofile
set undolevels=1000
set undoreload=10000

" Riv/InstantRst
let g:instant_rst_browser = 'chrome'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" vim-go settings
let g:go_fmt_command = "goimports"

" override syntastic settings for go
let g:syntastic_go_checkers = ['gometalinter']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" eslint for js
let g:syntastic_javascript_checkers = ['eslint']

" syntastic python
let g:syntastic_python_checkers = ['flake8']

" Add myself as a default recipient
let g:GPGDefaultRecipients = ["raizyr@gmail.com"]

" vim-markdown customizations
let g:markdown_enable_spell_checking = 0

" YCM customizations
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"youcompleteme with pyenv support
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
let g:ycm_python_binary_path = '/Users/raizyr/.pyenv/shims/python'

" PEP8 indentation
"au BufNewFile,BufRead *.py
    "\ set tabstop=4 |
    "\ set softtabstop=4 |
    "\ set shiftwidth=4 |
    "\ set textwidth=79 |
    "\ set expandtab |
    "\ set autoindent |
    "\ set smartindent |
    "\ set fileformat=unix |

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred

" Flag python bad whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" fullstack indentation
au BufNewFile,BufRead *.js,*.html,*.css,*.json
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set smartindent |

" terraform indentation
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1
"au BufNewFile, BufRead *.tf,*.tfvars
    "\ set tabstop=2 |
    "\ set softtabstop=2 |
    "\ set shiftwidth=2 |
    "\ set expandtab |
    "\ set autoindent |
    "\ set smartindent |
    "\ set fileformat=unix |


let python_highlight_all=1

" 2 character tabs
set tabstop=2

syntax enable
set background=dark
set termguicolors
set textwidth=0

" Returns the list of available color schemes
function! GetColorSchemes()
    return uniq(sort(map(
    \  globpath(&runtimepath, "colors/*.vim", 0, 1),
    \  'fnamemodify(v:val, ":t:r")'
    \)))
endfunction

let s:schemes = GetColorSchemes()
if index(s:schemes, 'material-monokai') >= 0
    let g:airline_theme='materialmonokai'
    let g:materialmonokai_italic=1
    colorscheme papercolor
endif



