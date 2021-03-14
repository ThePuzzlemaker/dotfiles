# Defined in - @ line 1
function s!! --wraps='eval $history[1]' --description 'alias s!!=eval $history[1]'
  eval $history[1] $argv;
end
