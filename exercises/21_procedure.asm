STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    msg db "The sum is: ", 0xA, 0xD
    len equ $- msg

section .bss
    res resb 1

section .text
    global main

main:
    mov ecx, '4'
    sub ecx, '0'
    mov edx, '5'
    sub edx, '0'
    call sum    ;call sum procedure
    mov [res], eax
    
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    nwln
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, res
    mov edx, 1
    int 0x80

    mov eax, SYS_EXIT
    int 0x80

sum:
    mov eax, ecx
    add eax, edx
    add eax, '0'
    ret ;back to where the procedure is called