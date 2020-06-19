function mkcd --description 'mkdir + cd' --no-scope-shadowing
	if test (count $argv) -eq 0
		echo "usage: mkcd <directory>"
	else
		mkdir $argv && cd $argv
	end
end
