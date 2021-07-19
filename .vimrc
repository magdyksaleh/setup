set nu rnu
syntax on
command C let @/=""
set autoindent
set smartindent
set expandtab
set shiftwidth=3
set softtabstop=3
set tabstop=3
set hlsearch
filetype plugin indent on

set mouse=a
set laststatus=2
set completeopt=menu,preview
set foldmethod=indent
set foldlevel=99
set background=dark

nmap j gj
nmap k gk

"FZF
:map <Leader>f :Files<CR>
:map <Leader>F :Files ..<CR>

" Ripgrep
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
:map <Leader>r :Find<CR>

" remove shift hell 
:command Wq wq
:command W w

nnoremap <Leader>b oimport pdb; pdb.set_trace()<Esc>

nnoremap <Leader>s :update<cr>
inoremap <Leader>s <Esc>:update<cr>

nnoremap <Leader>q :q<cr>
inoremap <Leader>q <Esc>:q<cr>

" Add Language Server Support 
set hidden
set runtimepath+=~/.vim/manual-plugins/LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'python': ['/home/magdy/.virtualenvs/siftenv/bin/pyls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" indent 2 spaces for js
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set nocompatible
set runtimepath+=~/.vim/bundle/Vundle.vim
call plug#begin("~/.vim/plugged")

" Add plugins here
set rtp+=~/.fzf
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
call plug#end()

" coc nvim   
let g:coc_disable_startup_warning = 1
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" split and open definition in tab
nnoremap <silent> vd :call CocAction('jumpDefinition', 'vsplit')<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
