;Caesar cipher (shift)
STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    plaintext db "password123", 0   ;source
    len equ $- plaintext

section .bss
    ciphertext resb len             ;destination

section .text
    global main

main:
    mov ecx, len
    mov esi, plaintext  ;esi points to the source
    mov edi, ciphertext ;edi points to the destination

shift:
    lodsb   ;loading operand into register (for bytes - LODSB, for words - LODSW, for doublewords - LODSD)
    add al, 02
    stosb   ;copying data from AL (for bytes - STOSB, for words - STOSW, for doublewords - STOSD)
    loop shift
    cld
    rep movsb
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, ciphertext
    mov edx, len
    int 0x80

    mov eax, SYS_EXIT
    int 0x80