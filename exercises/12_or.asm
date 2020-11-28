STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .bss
    result resb 1

section .text
    global main

main:
    mov al, 5           ;getting 5 in the AL register
    mov bl, 3           ;getting 3 in the BL register
    or al, bl           ;or al and bl registers, result should be 7
    add al, byte '0'    ;convert decimal to ASCII
    mov [result], al

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, result
    mov edx, SYS_EXIT
    int 0x80