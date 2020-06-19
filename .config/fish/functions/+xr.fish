# Defined in - @ line 1
function +xr --wraps='chmod -R +x' --description 'alias +xr=chmod -R +x'
  chmod -R +x $argv;
end
