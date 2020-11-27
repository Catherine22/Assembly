!/bin/bash

FILE=$(echo $1 | sed 's=.asm$==;s/\.$//')
# This script is for x86_64 architecture, you could run $lscpu to check
echo "Assembling with Nasm"
nasm -f elf64 -o $FILE.o $FILE.asm
echo "Linking ... "
gcc -m64 -o $FILE $FILE.o
echo "Done!"
./$FILE