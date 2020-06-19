# Defined in - @ line 1
function bash --description 'alias bash=env USE_BASH=1 bash'
	env USE_BASH=1 bash $argv;
end
