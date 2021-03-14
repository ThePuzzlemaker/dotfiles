function Misc_pre()
  " Disable netrw
  let loaded_netrwPlugin = 1

  " Mouse support
  set mouse=a

  " Tab characters
  set expandtab
  set tabstop=4
  set shiftwidth=4

  " fzf files list
  nnoremap <leader>; <Cmd>Files<CR>

  " Tab commands
  nnoremap <leader>to :<C-u>tabnew<space>
  nnoremap <leader>tn <Cmd>tabnext<CR>
  nnoremap <leader>tb <Cmd>tabprevious<CR>
  nnoremap <leader>tr <Cmd>tabrewind<CR>
  nnoremap <leader>tf <Cmd>tabfirst<CR>
  nnoremap <leader>tl <Cmd>tablast<CR>
  nnoremap <leader>tc <Cmd>tabclose<CR>
endfunction

function Misc_plug(Plug)
  " fzf
  call a:Plug('junegunn/fzf.vim')

  " Comment helpers
  call a:Plug('preservim/nerdcommenter')

  " Automatically set tab width
  call a:Plug('tpope/vim-sleuth')

  " Editing encrypted files
  call a:Plug('jamessan/vim-gnupg')
endfunction
