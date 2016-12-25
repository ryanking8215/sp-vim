" vim: set sw=4 ts=4 sts=4 tw=78 foldmarker={,} foldlevel=1 foldmethod=marker :
"
" Description:  This is simple and single file for spacemacs like configurations
" Version:      0.9.0
" Author:       ryanking8215

" Layers
let s:Layers = ['better-default', 'programming', 'git', 'python', 'go']

" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

" }

" Packages {
    call plug#begin('~/.vim/plugged')

    " better-default {
    if count(s:Layers, 'better-default')
        Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
        augroup nerd_loader
            autocmd!
            autocmd VimEnter * silent! autocmd! FileExplorer
            autocmd BufEnter,BufNew *
                        \  if isdirectory(expand('<amatch>'))
                        \|   call plug#load('nerdtree')
                        \|   execute 'autocmd! nerd_loader'
                        \| endif
        augroup END

        Plug 'Xuyuanp/nerdtree-git-plugin',             { 'on': 'NERDTreeToggle' }
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
        Plug 'tpope/vim-surround'
        " Plug 'Raimondi/delimitMate'
        Plug 'itchyny/vim-cursorword'
        Plug 'easymotion/vim-easymotion'
        " Plug 'haya14busa/incsearch-easymotion.vim'
        " Plug 'terryma/vim-multiple-cursors'
        " Plug 'danro/rename.vim',               { 'on' : 'Rename' }
        " Plug 'ntpeters/vim-better-whitespace', { 'on': 'StripWhitespace' }
        Plug 'matchit.zip'
        Plug 'vim-airline/vim-airline'
        Plug 'mbbill/undotree'
        Plug 'mileszs/ack.vim'
        Plug 'ctrlpvim/ctrlp.vim'
    endif
    " }

    " programming {
        if count(s:Layers, 'programming')
            Plug 'majutsushi/tagbar'
            Plug 'tomtom/tcomment_vim'
            if has('lua')
                let s:ac='neocomplete'
                Plug 'Shougo/neocomplete.vim'
            else
                let s:ac='neocomplcache'
                Plug 'Shougo/neocomplcache.vim'
            endif
            Plug 'Shougo/neosnippet'
            Plug 'Shougo/neosnippet-snippets'
            Plug 'spf13/vim-autoclose'
            Plug 'junegunn/vim-easy-align'
            Plug 'vim-syntastic/syntastic'
        endif
    " }

    " git {
        if count(s:Layers, 'git')
            Plug 'tpope/vim-fugitive'
            Plug 'airblade/vim-gitgutter'
       endif
    " }

    " python {
        if count(s:Layers, 'python')
            Plug 'davidhalter/jedi-vim'
        endif
    " }

    " go {
        if count(s:Layers, 'go')
            Plug 'fatih/vim-go'
        endif
    " }

    " user-customed {
        " lucius theme
        Plug 'jonathanfilip/vim-lucius'
    " }

    call plug#end()
"}

" Config and Keybindings {
    " base {
        " Config {
            let mapleader = "\<Space>"
            let maplocalleader = ','

            " set indent=smartindent

            if has('clipboard')
                if has('unnamedplus')  " When possible use + register for copy-paste
                    set clipboard=unnamed,unnamedplus
                else         " On mac and Windows, use * register for copy-paste
                    " set clipboard=unnamed
                endif
            endif

            "set autowrite                      " Automatically write a file when leaving a modified buffer
            set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
            set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
            set virtualedit=onemore             " Allow for cursor beyond last character
            set history=1000                    " Store a ton of history (default is 20)
            set nospell                         " Spell checking off
            set hidden                          " Allow buffer switching without saving
            set iskeyword-=.                    " '.' is an end of word designator
            set iskeyword-=#                    " '#' is an end of word designator
            set iskeyword-=-                    " '-' is an end of word designator

            syn on
            set ruler
            set cursorline
            set laststatus=2
            set backspace=indent,eol,start  " Backspace for dummies
            set linespace=0                 " No extra spaces between rows
            set number                      " Line numbers on
            set showmatch                   " Show matching brackets/parenthesis
            set incsearch                   " Find as you type search
            set hlsearch                    " Highlight search terms
            set winminheight=0              " Windows can be 0 line high
            " set ignorecase                  " Case insensitive search
            set smartcase                   " Case sensitive when uc present
            set wildmenu                    " Show list instead of just completing
            " set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
            set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
            set scrolljump=5                " Lines to scroll when cursor leaves screen
            set scrolloff=3                 " Minimum lines to keep above and below cursor
            " set foldenable                " Auto fold code
            set list
            set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

            set nowrap                      " Do not wrap long lines
            set smartindent
            set shiftwidth=4                " Use indents of 4 spaces
            set expandtab                   " Tabs are spaces, not tabs
            set tabstop=4                   " An indentation every four columns
            set softtabstop=4               " Let backspace delete indent
            set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
            set splitright                  " Puts new vsplit windows to the right of the current
            set splitbelow                  " Puts new split windows to the bottom of the current

            if !has('gui_running')
                set t_Co=256
            endif

            " syntax off if size is too big
            autocmd BufReadPre *
                        \   if getfsize(expand("%")) > 10000000 |
                        \   syntax off |
                        \   endif

        " }
        " Keybindings {
            " windows
            nnoremap <leader>ww <C-w>w
            nnoremap <leader>wj <C-w>j
            nnoremap <leader>wh <C-w>h
            nnoremap <leader>wk <C-w>k
            nnoremap <leader>wl <C-w>l
            nnoremap <leader>wl <C-w>l
            nnoremap <leader>ws <C-w>s
            nnoremap <leader>wh <C-w>h
            nnoremap <leader>wm <C-w>o
            nnoremap <leader>wo <C-w>o

            " buffers
            nnoremap <leader>bp :bp<cr>
            nnoremap <leader>bn :bn<cr>
            nnoremap <leader>bd :bd<cr>

            " utils
            nmap 0 ^
            nmap Y y$
            nnoremap <leader>qq <Esc>:qa<CR>
            " Reload .vimrc
            nnoremap <Leader>fR :source ~/.vimrc<CR>
        " }
    " }

    " better-default {
        if count(s:Layers, 'better-default')
            " Config {
                " airline {
                    let g:airline#extensions#tabline#enabled=0
                    let g:airline_powerline_fonts=0

                    if g:airline_powerline_fonts==1
                        let g:Powerline_symbols='fancy'
                        let Powerline_symbols='compatible'
                    else
                        if !exists('g:airline_symbols')
                           let g:airline_symbols = {}
                        endif
                        "" unicode symbols
                        "let g:airline_left_sep = '>'
                        let g:airline_left_sep = '▶'
                        ""let g:airline_right_sep = '<'
                        let g:airline_right_sep = '◀'
                        "let g:airline_symbols.linenr = '␊'
                        let g:airline_symbols.linenr = '␤'
                        ""let g:airline_symbols.linenr = '¶'
                        let g:airline_symbols.branch = '⎇'
                        let g:airline_symbols.paste = 'ρ'
                        "let g:airline_symbols.paste = 'Þ'
                        ""let g:airline_symbols.paste = '∥'
                        let g:airline_symbols.whitespace = 'Ξ'
                    endif
                " }
                " ack.vim {
                    if executable('ag')
                        let g:ackprg = 'ag --vimgrep'
                    endif
                " }
                " nerdtree {
                    let g:NERDTreeShowHidden=1
                    let g:NERDTreeAutoDeleteBuffer=1
                    " let g:NERDTreeDirArrowExpandable = '➤'
                    let g:NERDTreeIgnore=[
                                \ '\.py[cd]$', '\~$', '\.swo$', '\.swp$',
                                \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$',
                                \ ]
                    " close vim if the only window left open is a NERDTree
                    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
                " }
                "ctrlp {
                    let g:ctrlp_working_path_mode = 'ra'    " search for nearest ancestor like .git, .hg, and the directory of the current file
                    " let g:ctrlp_match_window_bottom = 0     " show the match window at the top of the screen
                    let g:ctrlp_by_filename = 1
                    let g:ctrlp_max_height = 15             " maxiumum height of match window
                    let g:ctrlp_switch_buffer = 'et'        " jump to a file if it's open already
                    let g:ctrlp_use_caching = 1             " enable caching
                    let g:ctrlp_clear_cache_on_exit=0       " speed up by not removing clearing cache evertime
                    let g:ctrlp_mruf_max = 250              " number of recently opened files
                    let g:ctrlp_custom_ignore = {
                                \   'dir':  '\v[\/]\.(git|hg|svn|build)$',
                                \   'file': '\v\.(exe|so|dll|pyc|o|a)$',
                                \   'link': 'SOME_BAD_SYMBOLIC_LINKS',
                                \ }
                    let g:ctrlp_switch_buffer = 'et'		" jump to a file if it's open already
                    let g:ctrlp_regexp = 1
                    " If ag available, use it to replace grep
                    if executable('ag')
                        " Use Ag over Grep
                        set grepprg=ag\ --nogroup\ --nocolor
                        " Use ag in CtrlP for listing files.
                        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
                        " Ag is fast enough that CtrlP doesn't need to cache
                        let g:ctrlp_use_caching = 0
                    else
                        let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
                    endif
                "}
            " }
            " Keybindings {
                nnoremap <Leader>ft :NERDTreeToggle<CR>
                nnoremap <Leader>ss :Ack!<Space>

                nnoremap <silent> <Leader>bb :CtrlPBuffer<CR>
                nnoremap <silent> <Leader>pf :CtrlP<CR>
            " }
        endif
    " }

    " programming {
        if count(s:Layers, 'programming')
            " Config {
                " syntastic {
                    let g:syntastic_always_populate_loc_list = 1
                    let g:syntastic_auto_loc_list = 1
                    let g:syntastic_check_on_open = 1
                    let g:syntastic_check_on_wq = 0
                " }

                if s:ac=='neocomplcache'
                    " TODO
                elseif s:ac=='neocomplete'
                    " neocomplete {
                        " Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
                        " Disable AutoComplPop.
                        let g:acp_enableAtStartup = 0
                        " Use neocomplete.
                        let g:neocomplete#enable_at_startup = 1
                        " Use smartcase.
                        let g:neocomplete#enable_smart_case = 1
                        " Set minimum syntax keyword length.
                        let g:neocomplete#sources#syntax#min_keyword_length = 3

                        " Define dictionary.
                        let g:neocomplete#sources#dictionary#dictionaries = {
                                    \ 'default' : '',
                                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                                    \ 'scheme' : $HOME.'/.gosh_completions'
                                    \ }

                        " Define keyword.
                        if !exists('g:neocomplete#keyword_patterns')
                            let g:neocomplete#keyword_patterns = {}
                        endif
                        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

                        " Plugin key-mappings.
                        inoremap <expr><C-g>     neocomplete#undo_completion()
                        inoremap <expr><C-l>     neocomplete#complete_common_string()

                        " Recommended key-mappings.
                        " <CR>: close popup and save indent.
                        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
                        function! s:my_cr_function()
                            return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
                            " For no inserting <CR> key.
                            "return pumvisible() ? "\<C-y>" : "\<CR>"
                        endfunction
                        " <TAB>: completion.
                        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
                        " <C-h>, <BS>: close popup and delete backword char.
                        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
                        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                        " Close popup by <Space>.
                        "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

                        " AutoComplPop like behavior.
                        "let g:neocomplete#enable_auto_select = 1

                        " Shell like behavior(not recommended).
                        "set completeopt+=longest
                        "let g:neocomplete#enable_auto_select = 1
                        "let g:neocomplete#disable_auto_complete = 1
                        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

                        " Enable omni completion.
                        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
                        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
                        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
                        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
                        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

                        " Enable heavy omni completion.
                        if !exists('g:neocomplete#sources#omni#input_patterns')
                            let g:neocomplete#sources#omni#input_patterns = {}
                        endif
                        "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
                        "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
                        "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

                        " For perlomni.vim setting.
                        " https://github.com/c9s/perlomni.vim
                        let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
                    " }
                else
                endif
            " }
            " Keybindings {
                nnoremap <leader>tt :TagbarToggle<CR>
            " }
        endif
    " }

    " git {
        if count(s:Layers, 'git')
            " Config {
            " }
            " Keybindings {
                nmap <silent> <leader>gs :Gstatus<CR>
                nmap <leader>gg :Git<space>
            " }
       endif
    " }

    " python {
        if count(s:Layers, 'python')
            " Config {
                au BufNewFile,BufRead *.py
                            \ setlocal tabstop=4 |
                            \ setlocal softtabstop=4 |
                            \ setlocal shiftwidth=4 |
                            \ setlocal textwidth=79 |
                            \ setlocal expandtab |
                            \ setlocal autoindent |
                            \ setlocal foldmethod=indent |
                            \ setlocal foldlevel=99 |

                " jedi-vim {
                    let g:jedi#popup_select_first=0
                    let g:jedi#auto_vim_configuration = 0
                    let g:jedi#popup_on_dot = 0
                    if has('python3')
                        let g:jedi#force_py_version = 3
                    endif
                " }
                " ac {
                    autocmd FileType python setlocal omnifunc=jedi#completions
                    if s:ac == 'neocomplete'
                        let g:neocomplete#sources#omni#input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
                    elseif s:ac == 'neocomplcache'
                        " TODO
                    endif
                " }
            " }
            " Keybindings {
                let g:jedi#goto_command = "<localleader>g"
                let g:jedi#goto_assignments_command = "<localleader>a"
                let g:jedi#goto_definitions_command = "<loalleader>d"
                let g:jedi#usages_command = "<localleader>n"
            " }
        endif
    " }

    " go {
        if count(s:Layers, 'go')
            " Config {
                " let g:go_highlight_functions = 1
                " let g:go_highlight_methods = 1
                " let g:go_highlight_fields = 1
                " let g:go_highlight_types = 1
                " let g:go_highlight_operators = 1
                " let g:go_highlight_build_constraints = 1

                let g:go_get_update = 0
                let g:go_list_type = "quickfix"
            " }
            " Keybindings {
                au FileType go nmap <localleader>d <Plug>(go-def-split)
            " }
        endif
    " }

    " user-customed {
        " Config {
            color lucius
            LuciusDark
            set fileencodings=utf-bom,utf8,gb2312,latin,default
        " }
        " Keybindings {
        " }
    " }
" }

