# Defined in - @ line 1
function pkg
	which "$argv" 1>/dev/null && pkgfile (which "$argv");
end
