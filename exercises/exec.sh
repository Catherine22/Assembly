#!/bin/bash
# This script is for x86_64 architecture, you could run $lscpu to check
# If you are using x86_32, replace 'elf64' to 'elf32' and '-m64' to '-m32'

FILE=$(echo $1 | sed 's=.asm$==;s/\.$//')
check_status() {
    if [[ "${?}" -ne 0 ]]
        then
        echo "The ${@} command did not work successfully." >&2 # STDERR
        exit 1
    fi
}
log() {
    local MESSAGE="${@}"
    echo "${MESSAGE}"
}

log "Assembling with Nasm"
nasm -f elf64 -o $FILE.o $FILE.asm
check_status "nasm"

log "Linking..."
gcc -m64 -o $FILE $FILE.o
check_status "gcc"

log "Executing..."
./$FILE

echo ""
exit 0