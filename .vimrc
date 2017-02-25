set nocompatible              " be iMproved, required
filetype off                  " required
set nu                        " turn on line numbering
"syntax on                     " turn on syntax highlighting

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'derekwyatt/vim-scala'
Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'Shougo/neocomplete'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on
set ignorecase
set smartcase
colorscheme koehler
let g:go_fmt_command = "goimports"
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:go_metalinter_deadline='20s'
let g:go_list_type = "quickfix"

" YCM Logging
" let g:ycm_keep_logfiles = 1
" let g:ycm_log_level = 'debug'

set splitright
" auto close braces
inoremap {<CR> {<CR>}<C-o>O
call neocomplete#custom#source('_', 'sorters', [])
"let g:neocomplete#enable_at_startup = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#cmd#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

let mapleader = ","

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>d <Plug>(go-doc)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)

" go command status (requires vim-go)
set statusline+=%#goStatuslineColor#
set statusline+=%{go#statusline#Show()}
set statusline+=%*
