# Allow all gdbinit automatically
set auto-load safe-path /

# Boo! Pagination bad (at least in GDB)!
set pagination off

# Hackery beyond my level of gdbinitery
source ~/.gdbinit.py

# Allow manual loading of pwndbg more easily
define pwnmode
  dont-repeat
  source /usr/share/pwndbg/gdbinit.py
end

# Only automatically load pwndbg for x86(_64)
if $X86 == 1
  pwnmode
end
