function Completion_pre()
  " CoC settings and autocmds

  " S-Tab/Tab move up/down completion list respsectively
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

  inoremap <silent><expr> <C-space> coc#refresh()

  " Go-to definition/implementation/refs
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gt <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Code actions at cursor
  nmap <silent> <M-Enter> <Plug>(coc-codeaction-cursor)

  " Rename/refactor
  nmap <F2> <Plug>(coc-rename)

  " CoC diagnostics list
  nnoremap <silent> <space>e <Cmd>CocList diagnostics<CR>
endfunction

function Completion_plug(Plug)
  call a:Plug('neoclide/coc.nvim', { 'branch': 'release' })
endfunction
