STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    achar db '0'

section .text
    global main

main:
    call display
    mov eax, SYS_EXIT
    int 0x80

display:
    mov rcx, 256

next:
    push rcx
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, achar
    mov edx, 1
    int 0x80
    pop rcx
    mov dx, [achar]
    cmp byte [achar], 0dh
    inc byte [achar]
    loop next
    ret
