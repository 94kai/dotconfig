vim.keymap.set({'n'},'<Leader>tw',':FloatermNew<CR>',{silent=true})
vim.keymap.set({'t'},'<Leader>tw','<C-\\><C-n>:FloatermNew<CR>',{silent=true})

vim.keymap.set({'n'},'<Leader>tt',':FloatermToggle<CR>',{silent=true})
vim.keymap.set({'t'},'<Leader>tt','<C-\\><C-n>:FloatermToggle<CR>',{silent=true})

vim.keymap.set({'n'},'<Leader>tp',':FloatermPrev<CR>',{silent=true})
vim.keymap.set({'t'},'<Leader>tp','<C-\\><C-n>:FloatermPrev<CR>',{silent=true})

vim.keymap.set({'n'},'<Leader>tn',':FloatermNext<CR>',{silent=true})
vim.keymap.set({'t'},'<Leader>tn','<C-\\><C-n>:FloatermNext<CR>',{silent=true})

vim.keymap.set({'n'},'<Leader>tk',':FloatermKill<CR>',{silent=true})
vim.keymap.set({'t'},'<Leader>tk',':<C-\\><C-n>:FloatermKill<CR>',{silent=true})
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'right'
