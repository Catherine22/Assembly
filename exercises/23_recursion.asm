;Fact (n) = n * fact (n-1) for n > 0
STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    msg db "Factorial 3 is: ", 0xA, 0xD
    len equ $- msg

section .bss
    fact resb 1

section .text
    global main

main:
    mov bx, 3   ;for calculating factorial 3
    call proc_fact
    add ax, 30h
    mov [fact], ax

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, fact
    mov edx, 1
    int 0x80

    mov eax, SYS_EXIT
    int 0x80

proc_fact:
    cmp bl, 1
    jg proc_calculation
    mov ax, 1
    ret

proc_calculation:
    dec bl
    call proc_fact
    inc bl
    mul bl  ;ax = al * bl
    ret