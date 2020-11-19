call plug#begin()

Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'Valloric/YouCompleteMe'
Plug 'rhysd/vim-crystal'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

call plug#end()

" ==================================================
" ==================== Settings ====================
syntax on
set number		" Show line numbers
set ignorecase		" Search case insensitive...
set smartcase		" ... but not if it begins with upper case
set splitright		" Split vertical windows right of the current window
set splitbelow		" Split horizontal windows below the current window
set hlsearch		" Highlight found search

colorscheme koehler
" sets parenthesis matching color
hi MatchParen cterm=bold ctermbg=none ctermfg=blue

" ==================================================
" ==================== Mappings ====================
let mapleader = ","
" auto close braces
inoremap {<CR> {<CR>}<C-o>O
" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

" =================================================
" ==================== Plugins ====================

" ==================== YouCompleteMe ====================
let g:ycm_autoclose_preview_window_after_insertion=1

" ==================== vim-go ====================
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

" go command status (requires vim-go)
" set statusline+=%#goStatuslineColor#
" set statusline+=%{go#statusline#Show()}
" set statusline+=%*

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

augroup go
	autocmd!
	autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)

	autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	autocmd FileType go nmap <leader>t  <Plug>(go-test)
	autocmd FileType go nmap <leader>r  <Plug>(go-run)

	autocmd FileType go nmap <Leader>d <Plug>(go-doc)
	autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
augroup END
