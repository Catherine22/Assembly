STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .text 
    global main

main:
    mov ax, 8h              ;getting 8 in the ax
    and ax, 1               ;and ax with 1
    jz evnn
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, odd_msg
    mov edx, len2

    int 0x80
    jmp outprog evnn:
    mov ah, 09h 
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, even_msg
    mov edx, len1
    int 0x80

outprog: 
    mov eax, SYS_EXIT
    int 0x80

section .data
    even_msg db 'Even Number!'
    len1 equ $ - even_msg 
    odd_msg db 'Odd Number!'
    len2 equ $ - odd_msg 