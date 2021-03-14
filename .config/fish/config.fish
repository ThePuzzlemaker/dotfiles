eval (~/.config/fish/angel-PS1 -c ~/.config/fish/custom.PS1)
set -x PATH $PATH ~/.yarn/bin
set -x MAKEFLAGS -j4
set -x VISUAL nvim
set -x EDITOR nvim
set -x BROWSER firefox
set -x PATH ~/.mix/ $PATH
set -x PATH ~/.cargo/bin $PATH
set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow --exclude .git --exclude .vim
kitty + complete setup fish | source
diesel completions fish | source
