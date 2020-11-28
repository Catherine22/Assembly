STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    even_msg db "Even Number!", 0xA
    len1 equ $- even_msg 
    odd_msg db "Odd Number!", 0xA
    len2 equ $- odd_msg 

section .text 
    global main

main:
    mov ax, 6h              ;getting 8 in the ax
    test ax, 1              ;what TEST does is similar to AND, but TEST does not change it's value
    jz evnn
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, odd_msg
    mov edx, len2

    int 0x80
    jmp outprog 

evnn:
    mov ah, 09h 
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, even_msg
    mov edx, len1
    int 0x80

outprog: 
    mov eax, SYS_EXIT
    int 0x80