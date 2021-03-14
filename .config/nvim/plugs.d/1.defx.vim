function Defx_pre()
  " Keymaps for defx
  nnoremap <silent> <Leader>e <Cmd>Defx<CR>

  autocmd FileType defx call s:defx_explorer_keymaps()
endfunction

function Defx_plug(Plug)
  call a:Plug('Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' })
  call a:Plug('kristijanhusak/defx-icons')
  call a:Plug('kristijanhusak/defx-git')
endfunction

function Defx_post()
  call defx#custom#option('_', {
  \ 'winwidth': 50, 'winheight': &lines,
  \ 'winrow': 0, 'wincol': 0,
  \ 'direction': 'topleft',
  \ 'toggle': 1, 'resume': 1,
  \ 'split': 'floating',
  \ 'buffer_name': 'explorer',
  \ 'columns': 'indent:git:icons:filename:mark'
  \ })
endfunction

function s:defx_explorer_keymaps()
  " Open file/folder
  nnoremap <silent><buffer><expr> <Enter>
  \ defx#is_directory() ? defx#do_action('open_tree', 'toggle')
  \ : defx#do_action('multi', ['quit', ['drop', 'tabedit']])
  
  " Split file/folder vertically
  nnoremap <silent><buffer><expr> sv
  \ defx#do_action('drop', 'vsplit')

  " Split file/folder horizontally
  nnoremap <silent><buffer><expr> sh
  \ defx#do_action('drop', 'hsplit')

  " cd into folder
  nnoremap <silent><buffer><expr> l
  \ defx#is_directory() ? defx#do_action('open') : 0

  " cd ..
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  
  " Create directory
  nnoremap <silent><buffer><expr> nd
  \ defx#do_action('new_directory')
  
  " Create file
  nnoremap <silent><buffer><expr> nf 
  \ defx#do_action('new_file')
 
  " Delete file and move to trash
  nnoremap <silent><buffer><expr> dd
  \ defx#do_action('remove_trash')
  
  " Rename file
  nnoremap <silent><buffer><expr> rn
  \ defx#do_action('rename')

  " Copy file
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')

  " Cut file
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('move')

  " Paste file
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')

  " Select/deselect file
  nnoremap <silent><buffer><expr> s
  \ defx#do_action('toggle_select')

  " Exit explorer
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
endfunction
