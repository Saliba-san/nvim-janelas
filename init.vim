""""""""""
"  Geral  "
"""""""""""
  syntax on
  filetype plugin indent on
  set nocompatible
  set encoding=utf-8
  set noerrorbells
  set expandtab
  set tabstop=2 softtabstop=2
  set shiftwidth=2
  set scrolloff=2 
  set number relativenumber
  set smartindent
  set smartcase
  set nospell
  set noshowmode
  set nobackup
  set undodir=$HOME/.config/nvim/undodir
  set undofile
  set incsearch
  set ignorecase
  set nowrap
  set mouse=a
  autocmd! bufwritepost $MYVIMRC source $MYVIMRC
  autocmd! BufReadPost $MYVIMRC set foldmethod=indent

""""""""""""""
"  Vim Plug  "
""""""""""""""
  call plug#begin('C:/Users/DELL/AppData/Local/nvim/plugged')
  "Style
    "Colorschemes
      Plug 'morhetz/gruvbox'
      Plug 'sainnhe/gruvbox-material'
    "StatusLine
      Plug 'itchyny/lightline.vim'
  "Langs
    Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
    Plug 'plasticboy/vim-markdown'
    Plug 'mxw/vim-jsx'
    Plug 'mattn/emmet-vim'
    Plug 'pangloss/vim-javascript'
    Plug 'lervag/vimtex'
    Plug 'jalvesaq/Nvim-R'
    Plug 'stevearc/vim-arduino'
    Plug 'OmniSharp/omnisharp-vim'
  "Editor
    Plug 'tpope/vim-repeat'
    Plug 'preservim/nerdtree'
    Plug 'ervandew/supertab'
    Plug 'airblade/vim-rooter'
    " Telescope
      Plug 'nvim-telescope/telescope.nvim'
      Plug 'nvim-lua/popup.nvim'
      Plug 'nvim-lua/plenary.nvim'
    "FZF
      Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
      Plug 'junegunn/fzf.vim'
  "Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
  "Linter
    Plug 'dense-analysis/ale'
  "GoYo
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
  "LSP
    Plug 'neovim/nvim-lspconfig'
	"	Plug 'nvim-lua/completion-nvim'
	"	Plug 'nvim-lua/diagnostic-nvim'
	"TreeSitter
		Plug 'nvim-treesitter/nvim-treesitter', {'commit': '3c07232'}  
    
  call plug#end()

"""""""""""
"  Style  "
"""""""""""
  "Colors
    set termguicolors
    colorscheme gruvbox-material
    noremap <C-F8> :source C:\\Users\DELL\AppData\Local\nvim\vimscripts\setcolors.vim<CR> 
    hi SpellBad gui=underline guifg=none
    hi Search guibg=Grey30

  "StatusLine
    function! GitStatus()
      let [a,m,r] = GitGutterGetHunkSummary()
      if ( a != 0 || m != 0 || r != 0)
        return printf('+%d ~%d -%d', a, m, r)
      else
        return ""
      endif
   endfunction

    let g:lightline = {
          \ 'colorscheme': 'jellybeans',
          \ 'active': {
          \   'left': [ [ 'mode' ],
          \             [ 'filename', 'modified'],
          \             [ 'gitbranch', 'gitdiff'] ], 
          \   'right': [ [ 'lineinfo' ],
          \              [  'percent', 'bufnum'],
          \              [ 'filetype'] ]
          \   },
          \ 'component_function': {
          \   'gitbranch': 'FugitiveHead',
          \   'gitdiff' : 'GitStatus',
          \   }
          \ }

""""""""""""""
"  Mappings  "
""""""""""""""
  "Leader
    map <SPACE> <Nop>
    let mapleader = " "

  "Remaps
    vnoremap Y "+y
    noremap <leader>s :%s//gc<left><left><left>
    noremap <backspace> :noh<CR>
    noremap <A-w> :set nowrap!<CR>
    noremap <A-p> :set paste!<CR>
    noremap <A-n> :set rnu!<CR>

  "Quickfix
		function! ToggleQuickFix()
			if getqflist({'winid' : 0}).winid
					cclose
			else
					copen
			endif
		endfunction
		command! -nargs=0 -bar ToggleQuickFix call ToggleQuickFix()
		nnoremap <silent> cq :ToggleQuickFix<CR>
    
  "Window
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

  "Tabs
    map <silent> <A-t> :tabnew<cr>
    map <silent> <A-c> :tabclose<cr>
    map <silent> <A-h> :tabp<cr>
    map <silent> <A-l> :tabn<cr>
    map <silent> <A-H> :+tabm<cr>
    map <silent> <A-L> :-tabm<cr>

  "Terminal
    tnoremap <ESC> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-h>
    tnoremap <C-j> <C-\><C-n><C-j>
    tnoremap <C-k> <C-\><C-n><C-k>
    tnoremap <C-l> <C-\><C-n><C-l>

  "Editor
    nnoremap <silent> <Left> :vertical resize -5<CR>
    nnoremap <silent> <Right> :vertical resize +5<CR>
    nnoremap <silent> <Up> :resize +5<CR>
    nnoremap <silent> <Down> :resize -5<CR>
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv

  "Insert
    inoremap ;" ""<left>
    inoremap ;' ''<left>
    inoremap ;( ()<left>
    inoremap ;[ []<left>
    inoremap ;{ {}<left>
    inoremap {<CR> <CR>{<CR>}<C-o>O
    inoremap ;{<CR> {<CR>}<ESC>O
    inoremap ;{;<CR> {<CR>};<ESC>O
    inoremap ;- <Esc>/<++><Enter>c4l
    inoremap ;m <++>

  "Visual
    vnoremap ;" "vc"<C-r>v"<ESC>
    vnoremap ;' "vc'<C-r>v'<ESC>
    vnoremap ;( "vc(<C-r>v)<ESC>
    vnoremap ;[ "vc[<C-r>v]<ESC>
    vnoremap ;{ "vc{<C-r>v}<ESC>

""""""""""""""
"  Markdown  "
""""""""""""""
  augroup Markdown
    autocmd VimEnter *.md set spell spelllang=pt_br
    autocmd VimEnter *.md set wrap
    " Insert
    autocmd Filetype markdown inoremap ;eq $$<CR>\begin{aligned}<CR>\end{aligned}<CR>$$<ESC>kO
    autocmd Filetype markdown inoremap ;ex e^{}<++><C-o>4h
    autocmd Filetype markdown inoremap ;eif \int^{\infty}_{-\infty}
    autocmd Filetype markdown inoremap ;ein \int^{}_{<++>}<++><C-o>11h
    autocmd Filetype markdown inoremap ;esf \sum^{\infty}_{k=-\infty}
    autocmd Filetype markdown inoremap ;esn \sum^{}_{<++>}<++><C-o>11h
    autocmd Filetype markdown inoremap ;f \frac{}{<++>}<++><C-o>10h
    autocmd Filetype markdown inoremap ;i ![](./<++>.png)<C-o>12h
    autocmd Filetype markdown inoremap ;. \cdot
    autocmd Filetype markdown inoremap ;v \vec{}<++><C-o>4h
    autocmd filetype markdown inoremap ;t **<++><C-o>4h
    autocmd filetype markdown inoremap ;b ****<++><C-o>5h
    autocmd filetype markdown inoremap ;tb ******<++><C-o>6h
    autocmd Filetype markdown inoremap #2 ##
    autocmd Filetype markdown inoremap #3 ###
    autocmd Filetype markdown inoremap #4 ####
    autocmd Filetype markdown inoremap #5 #####
    autocmd Filetype markdown inoremap ;$ $$<++><C-o>4h
    " Visual
    autocmd Filetype markdown vnoremap ;f do<ESC>p^^"fct/\frac{<C-r>f}<del>{<C-o>$} <ESC>dF\`<hpjddk
    autocmd Filetype markdown vnoremap ;i "mc![img](./<C-r>m.png)<ESC>
    autocmd Filetype markdown vnoremap ;. :s/*/\cdot/g<CR><backspace>
    autocmd filetype markdown vnoremap ;t "mc*<C-R>m*<ESC>
    autocmd filetype markdown vnoremap ;b "mc**<C-R>m**<ESC>
    autocmd filetype markdown vnoremap ;tb "mc***<C-R>m***<ESC>
    autocmd Filetype markdown vnoremap ;v "mc\vec{}<ESC>h"mp
    autocmd Filetype markdown vnoremap ;$ "mc$<C-r>m$<ESC>

    "Greek
    autocmd Filetype markdown inoremap ;ga \alpha
    autocmd Filetype markdown inoremap ;gb \beta
    autocmd Filetype markdown inoremap ;gd \delta
    autocmd Filetype markdown inoremap ;gD \Delta
    autocmd Filetype markdown inoremap ;ge \epsilon
    autocmd Filetype markdown inoremap ;gE \varepsilon
    autocmd Filetype markdown inoremap ;gm \mu
    autocmd Filetype markdown inoremap ;gw \omega
    autocmd Filetype markdown inoremap ;gp \pi
    autocmd Filetype markdown inoremap ;gf \phi
    autocmd Filetype markdown inoremap ;gF \Phi
    autocmd Filetype markdown inoremap ;gr \rho
    autocmd Filetype markdown inoremap ;gt \theta
    autocmd Filetype markdown inoremap ;gT \Theta
    autocmd Filetype markdown inoremap ;gg \gamma
    autocmd Filetype markdown inoremap ;gG \Gamma
    autocmd Filetype markdown inoremap ;gl \lambda
    
    " Windows 
    autocmd Filetype markdown nnoremap <C-s> :w<CR>:silent !"C:\\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe" "%:p"<CR>
  augroup END

"""""""""""
"  Latex  "
"""""""""""
  augroup Latex
    let g:tex_flavor = 'pdflatex'
    autocmd BufRead,BufNewFile *.Rnw set filetype=tex
    autocmd VimEnter *.tex set spell spelllang=pt_br
    autocmd VimEnter *.md set wrap
    " Insert
    autocmd filetype tex inoremap ;fig \begin{figure}[H]<CR>\centering<CR>\includegraphics{}<CR>\captions{}\label{}<CR>\end{figure}<ESC>2kwa
    autocmd filetype tex inoremap ;p \usepackage{}<left>
    autocmd filetype tex inoremap ;eq \begin{equation}<cr>\end{equation}o
    autocmd filetype tex inoremap ;s \section{}<left>
    autocmd filetype tex inoremap ;i \emph{}<left>
    autocmd filetype tex inoremap ;b \bold{}<left>
    autocmd filetype tex inoremap ;r \ref{}<left>
    " Visual
    autocmd filetype tex vnoremap ;$ c$<ESC>pa$<ESC>
    autocmd filetype tex vnoremap ;i c\emph{<ESC>pa}<ESC>
    autocmd filetype tex vnoremap ;b c\bold{<ESC>pa}<ESC>
    autocmd filetype tex vnoremap ;r c\ref{<ESC>pa}<ESC>
  augroup END

"""""""""""""
"  Plugins  "
"""""""""""""
	"Telescope
		"TelescopeBasic
			nnoremap <leader>tf <cmd>lua require('telescope.builtin').find_files()<cr>
			nnoremap <leader>tg <cmd>lua require('telescope.builtin').live_grep()<cr>
			nnoremap <leader>tgs <cmd>lua require('telescope.builtin').grep_string()<cr>
			nnoremap <leader>tgf <cmd>lua require('telescope.builtin').git_files()<cr>
			nnoremap <leader>tof <cmd>lua require('telescope.builtin').oldfiles()<cr>
			nnoremap <leader>tb <cmd>lua require('telescope.builtin').buffers()<cr>
			nnoremap <leader>tbt <cmd>lua require('telescope.builtin').current_buffer_tags()<cr>
			nnoremap <leader>tbf <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
			nnoremap <leader>th <cmd>lua require('telescope.builtin').help_tags()<cr>
			nnoremap <leader>tz <cmd>lua require('telescope.builtin').spell_suggest()<cr>
			nnoremap <leader>tm <cmd>lua require('telescope.builtin').marks()<cr>
			nnoremap <leader>tm <cmd>lua require('telescope.builtin').keymaps()<cr>
		"TelescopeLSP
			nnoremap <leader>tlr <cmd>lua require('telescope.builtin').lsp_references()<cr>
			nnoremap <leader>tlds <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
			nnoremap <leader>tlws <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
			nnoremap <leader>tld <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
			nnoremap <leader>tlw <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>
			nnoremap <leader>tlca <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
		"TelescopeGit
			nnoremap <leader>tgc <cmd>lua require('telescope.builtin').git_commits()<cr>
			nnoremap <leader>tgbc <cmd>lua require('telescope.builtin').git_bcommits()<cr>
			nnoremap <leader>tgb <cmd>lua require('telescope.builtin').git_branches()<cr>
			nnoremap <leader>tgs <cmd>lua require('telescope.builtin').git_status()<cr>
		"TelescopeTreesitter
			nnoremap <leader>tt <cmd>lua require('telescope.builtin').treesitter()<cr>

    "FZF
      "Default Configs
        let g:fzf_preview_window = []
        let g:fzf_buffers_jump = 1
				let g:fzf_nvim_statusline = 0 " disable statusline overwriting

        let g:fzf_action = {
          \ 'ctrl-t': 'tab split',
          \ 'ctrl-i': 'split',
          \ 'ctrl-s': 'vsplit' }
        set ttimeout
        set ttimeoutlen=0
        command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw('--color-path "1;36" '.shellescape(<q-args>), <bang>0)
      "Mappings
				nnoremap <silent> <leader>ff :Files<CR>
				nnoremap <silent> <leader>fg :GFiles<CR>
				nnoremap <silent> <leader>fa :Buffers<CR>
				nnoremap <silent> <leader>fA :Windows<CR>
				nnoremap <silent> <leader>f; :BLines<CR>
				nnoremap <silent> <leader>fo :BTags<CR>
				nnoremap <silent> <leader>fO :Tags<CR>
				nnoremap <silent> <leader>f? :History<CR>
				nnoremap <silent> <leader>f/ :execute 'Ag ' . input('Ag/')<CR>
				nnoremap <silent> <leader>f. :AgIn 

				nnoremap <silent> <leader>fk :call SearchWordWithAg()<CR>
				nnoremap <silent> <leader>fgl :Commits<CR>
				nnoremap <silent> <leader>fga :BCommits<CR>
				nnoremap <silent> <leader>ft :Filetypes<CR>
				imap <C-x><C-f> <plug>(fzf-complete-file-ag)
				imap <C-x><C-l> <plug>(fzf-complete-line)

				function! SearchWordWithAg()
					execute 'Ag' expand('<cword>')
				endfunction

				function! SearchWithAgInDirectory(...)
					call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
				endfunction
				command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
      

  "Markdown
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_autowrite = 1

  "Supertab
    let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
    let g:SuperTabDefaultCompletionType = "context"
    let g:SuperTabClosePreviewOnPopupClose = 1

  "Arduino
    nnoremap <leader>am :ArduinoVerify<CR>
    nnoremap <leader>au :ArduinoUpload<CR>
    nnoremap <leader>ad :ArduinoUploadAndSerial<CR>
    nnoremap <leader>ab :ArduinoChooseBoard<CR>
    nnoremap <leader>ap :ArduinoChooseProgrammer<CR>

  " Omnisharp
    augroup Csharp
      "Style
        autocmd FileType cs execute 'hi csConstant guifg=' . g:terminal_color_5
        autocmd FileType cs execute 'hi csString guifg=' . g:terminal_color_3
        autocmd Filetype cs set tabstop=4 softtabstop=4 shiftwidth=4
      "Mapping
        autocmd FileType cs nmap gd <Plug>(omnisharp_go_to_definition)
        autocmd FileType cs nmap gi <Plug>(omnisharp_find_implementations)
        autocmd FileType cs nmap gsq gi:sleep 200m<CR>jjf(lgd
        autocmd FileType cs nmap <Leader>fu <Plug>(omnisharp_find_usages)
        autocmd FileType cs nmap <Leader>fs <Plug>(omnisharp_find_symbol)
        autocmd FileType cs nmap <Leader>fx <Plug>(omnisharp_fix_usings)
        autocmd FileType cs nmap <Leader>pd <Plug>(omnisharp_preview_definition)
        autocmd FileType cs nmap <Leader>pi <Plug>(omnisharp_preview_implementations)
        autocmd FileType cs nmap <Leader>t <Plug>(omnisharp_type_lookup)
        autocmd FileType cs nmap <Leader>d <Plug>(omnisharp_documentation)
        autocmd FileType cs nmap <C-\> <Plug>(omnisharp_signature_help)
        autocmd FileType cs imap <C-\> <Plug>(omnisharp_signature_help)
      " Navigate up and down bfield
        autocmd FileType cs nmap [[ <Plug>(omnisharp_navigate_up)
        autocmd FileType cs nmap ]] <Plug>(omnisharp_navigate_down)
      " Find all code errors/wrrent solution and populate the quickfix window
        autocmd FileType cs nmap <Leader>cc <Plug>(omnisharp_global_code_check)
      " Contextual code actionlap, CtrlP or unite.vim selector when available)
        autocmd FileType cs nmap <Leader>ca <Plug>(omnisharp_code_actions)
        autocmd FileType cs xmap <Leader>ca <Plug>(omnisharp_code_actions)
      " Repeat the last code aoes not use a selector)
        autocmd FileType cs nmap <Leader>. <Plug>(omnisharp_code_action_repeat)
        autocmd FileType cs xmap <Leader>. <Plug>(omnisharp_code_action_repeat)
        autocmd FileType cs nmap <Leader>= <Plug>(omnisharp_code_format)

        autocmd FileType cs nmap <Leader>rn <Plug>(omnisharp_rename)

        autocmd FileType cs nmap <Leader>re <Plug>(omnisharp_restart_server)
        autocmd FileType cs nmap <Leader>st <Plug>(omnisharp_start_server)
        autocmd FileType cs nmap <Leader>sp <Plug>(omnisharp_stop_server)
      "Mouse
        autocmd CursorHold *.cs OmniSharpTypeLookup
    augroup END
    let g:OmniSharp_highlight_groups = {
        \ 'ClassName': 'Keyword',
        \ 'NamespaceName': 'SpecialChar',
        \ 'PropertyName': 'Punctuation',
        \ 'FieldName': 'Punctuation',
        \ 'StructName': 'Function',
        \ 'EnumName': 'Function'
        \}

  "Goyo
    map Q :Goyo 70%x85%<CR>
    function! s:goyo_enter()
        set noshowmode
        set noshowcmd
        set nocursorline
        setlocal spell spelllang=pt_br
        silent Limelight
        silent Prosa
    endfunction

    function! s:goyo_leave()
        set noshowmode
        set noshowcmd
        set nocursorline
        setlocal nospell
        Limelight!
        Prosa
    endfunction

    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave() 

  "NerdTree
    map <silent> <leader>n :NERDTreeToggle<CR>
    map <silent> <leader>N :NERDTreeFind<CR>

  "Emmet
    autocmd BufReadPost *.cshtml set ft=html

  "GitGutter
    map <silent> <leader>g : GitGutterToggle<CR>

  "Vim Rooter
    let g:rooter_patterns = ['=src','.git']

"""""""""""""
"  Prosa  "
"""""""""""""
  source C:\Users\DELL\AppData\Local\nvim\vimscripts\prosamode.vim

"""""""""""""
"  Lua  "
"""""""""""""
  lua require("lsp_config")
