STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    msg db "The largest digit is: "
    len equ $- msg
    num1 dd "57"
    num2 dd "37"
    num3 dd "97"

section .bss
    largest resb 2

section .text 
    global main

main:
    mov ecx, [num1]
    cmp ecx, [num2]
    jg cmp_num3   ;jump greater
    mov ecx, [num3]

    cmp_num3:
        cmp ecx, [num3]
        jg exit    ;jump greater
        mov ecx, [num3]
    
    exit:
        mov [largest], word ecx
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, msg
        mov edx, len
        int 0x80
        
        nwln
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, largest
        mov edx, 2
        int 0x80

        mov eax, 1
        int 80h
        