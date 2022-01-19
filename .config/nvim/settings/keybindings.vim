" Keybindings

" remove arrow key movement
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
	exec 'noremap' key '<Nop>'
    exec 'inoremap' key '<Nop>'
endfor

" NvimTree
nnoremap <silent> <A-e> :NvimTreeToggle<CR>

" reload nvim
nnoremap <silent> <A-r> :source ~/.config/nvim/init.vim<CR>
    
" tab line over
nnoremap o ^
nnoremap e >>^
nnoremap w <<^
nnoremap f za
