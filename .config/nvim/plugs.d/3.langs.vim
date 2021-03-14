function Langs_pre()
  let g:rustfmt_autosave = 1
  " Automatically format when leaving normal mode in rs files
  autocmd InsertLeave *.rs :call CocAction('format')
endfunction

function Langs_plug(Plug)
  call a:Plug('rust-lang/rust.vim')
  call a:Plug('cespare/vim-toml')
  call a:Plug('dag/vim-fish')
  call a:Plug('plasticboy/vim-markdown')
  call a:Plug('petRUShka/vim-sage')
endfunction
