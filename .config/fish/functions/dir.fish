# Defined in - @ line 1
function dir --wraps=ls --description 'alias dir=ls'
  ls  $argv;
end
