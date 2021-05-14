" Prosa mode
	command Prosa execute(":call ToggleProsa()") 
	map <leader>p :Prosa<CR>

	let g:ProsaOn=0
	function! ToggleProsa()
			if !g:ProsaOn
					call Prosa()
			else
					call ProsaOff()
			endif
	endfunction

	function! Prosa()
			echo "Prosa: On"
			let g:ProsaOn=1

			noremap j gj
			noremap k gk
			noremap 0 g0
			noremap $ g$
			setlocal linebreak nonumber norelativenumber foldcolumn=2
			setlocal spell spelllang=pt_br
			hi! link FoldColumn Normal

	endfunction

	function! ProsaOff()
			echo "Prosa: Off"
			let g:ProsaOn=0

			noremap j j
			noremap k k
			noremap 0 0
			noremap $ $
			setlocal nospell
			setlocal nolinebreak number relativenumber t_Co=256 foldcolumn=0
	endfunction
