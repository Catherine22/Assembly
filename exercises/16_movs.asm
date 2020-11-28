STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    s1 db "Hello, world!"   ;string 1
    len equ $- s1

section .bss
    s2 resb 20  ;destination

section .text
    global main

main:
    mov ecx, len
    mov esi, s1
    mov edi, s2
    cld
    rep movsb   ;moving (for bytes - MOVSB, for words - MOVSW, for doublewords - MOBSD) 
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, s2
    mov edx, 20
    int 0x80

    mov eax, SYS_EXIT
    int 0x80
