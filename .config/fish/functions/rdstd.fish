# Defined in - @ line 1
function rdstd --wraps='rustup doc --std' --description 'alias rdstd=rustup doc --std'
  rustup doc --std $argv;
end
