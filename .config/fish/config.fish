eval (~/.config/fish/angel-PS1 -c ~/.config/fish/custom.PS1)
set PATH $PATH /home/$USER/.cargo/bin
ssh-add -q ~/.ssh/id_rsa 2>&1 > /dev/null
set MAKEFLAGS -j4
set VISUAL nano
set EDITOR nano
# Make sure kitty completion is good
kitty + complete setup fish | source
