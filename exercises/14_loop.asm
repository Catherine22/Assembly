STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .bss
    num resb 2

section .text 
    global main

main:
    mov ecx, 10
    mov eax, '1'

l1:
    mov [num], eax
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    push ecx
    mov ecx, num
    mov edx, 1
    int 0x80

    mov eax, [num]
    sub eax, '0'
    inc eax
    add eax, '0'
    pop ecx
loop l1

    mov eax, STDOUT
    int 0x80