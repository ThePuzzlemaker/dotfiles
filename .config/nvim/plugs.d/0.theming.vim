function Theming_pre()
  set termguicolors
  set number relativenumber
  " indentLine characters
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  " Airline settings
  let g:airline_theme = "ayu_dark"
  let g:airline_powerline_fonts = 1
  " Enable airline tabline
  let g:airline#extensions#tabline#enabled = 1
  " Don't show buffers cause when I use tabs they confuse me
  let g:airline#extensions#tabline#show_buffers = 0
endfunction

function Theming_plug(Plug)
  call a:Plug('ryanoasis/vim-devicons')
  call a:Plug('vim-airline/vim-airline')
  call a:Plug('vim-airline/vim-airline-themes')
  call a:Plug('Yggdroot/indentLine')
  call a:Plug('ayu-theme/ayu-vim')
  call a:Plug('jeffkreeftmeijer/vim-numbertoggle')
endfunction

function Theming_post()
  " Ayu settings
  let ayucolor="dark"
  colorscheme ayu
endfunction
