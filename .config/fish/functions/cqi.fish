# Defined in - @ line 1
function cqi
	which "$argv" 1>/dev/null && pkgfile -q (which "$argv") 1>/dev/null && yay -Qi (pkgfile -q (which "$argv"));
end
