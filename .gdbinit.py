arch_str = gdb.execute('show architecture', to_string = True).split('\n')[0]

# Check if this architecture is x86(_64)
if ('i386' in arch_str):
  # Boo! AT&T syntax bad!
  gdb.execute('set disassembly-flavor intel')
  gdb.execute('set $X86=1')
else:
  gdb.execute('set $X86=0')
