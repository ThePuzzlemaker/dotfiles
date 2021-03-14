" This is mostly just some logic around loading the files in plugs.d
" automatically (in order to not clutter up this file a ton). See those files
" for more info. They contain up to three functions:
" Name_pre(): Stuff to do before loading Plugged
" Name_plug(Plug): Setup Plugged plugins (requires a little bit of hackery
"                  cause "yay vimscript"
" Name_post(): Stuff to do after loading Plugged (e.g. colorscheme)
" The `Name` in all these is the capitalization of the file's name, minus the
" order prefix (which may not be necessary, but can't hurt). For example:
" File name: `0.foo.vim`
" Pre function: `Foo_pre()`

" Automated installation of vimplug if not installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

function s:capitalize(str)
  if strlen(a:str) == 1
    return toupper(a:str)
  endif
  return toupper(a:str[0]) . a:str[1:]
endfunction

" Load pre, plug, and post functions for plugs.
let s:plug_scripts = globpath(&rtp, "plugs.d/*.vim", 0, 1)
let s:prefns = []
let s:plugfns = []
let s:postfns = []
for plug in s:plug_scripts
  execute "source " . fnameescape(plug)
  let plug_name = split(split(plug, "/")[-1], "\\.")[1]
  let prefn = s:capitalize(plug_name) . "_pre"
  let plugfn = s:capitalize(plug_name) . "_plug"
  let postfn = s:capitalize(plug_name) . "_post"
  if exists("*" . prefn)
    call add(s:prefns, funcref(prefn))
  endif
  if exists("*" . plugfn)
    call add(s:plugfns, funcref(plugfn))
  endif
  if exists("*" . postfn)
    call add(s:postfns, funcref(postfn))
  endif
  unlet plug_name
  unlet prefn
  unlet plugfn
  unlet postfn
  unlet plug
endfor

" Run pre-fns.
for Prefn in s:prefns
  call Prefn()
  unlet Prefn
endfor

call plug#begin('~/.config/nvim/plugged')

" Run plug-fns, in the context of Plugged.
for Plugfn in s:plugfns
  " We have to use `call a:Plug` cause `Plug` and even `call plug#` wouldn't
  " work. `Plug` is just an alias for `plug#`.
  call Plugfn(funcref("plug#"))
  unlet Plugfn
endfor

call plug#end()

" Run post-fns.
for Postfn in s:postfns
  call Postfn()
  unlet Postfn
endfor
