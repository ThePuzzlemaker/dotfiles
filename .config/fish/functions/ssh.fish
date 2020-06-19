# Defined in - @ line 1
function ssh --wraps='kitty +kitten ssh' --description 'alias ssh=kitty +kitten ssh'
  kitty +kitten ssh $argv;
end
