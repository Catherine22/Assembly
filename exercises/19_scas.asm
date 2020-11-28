STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    my_string db "password", 0
    len equ $- my_string
    msg1 db "found!", 0xA
    len_found equ $- msg1
    msg2 db "not found!", 0xA
    len_notfound equ $- msg2

sectoin .text
    global main

main:
    mov ecx, len
    mov edi, my_string
    mov, al 'a'
    cld
    repne scasb
    je found    ;when found

    ;if not found then the following code
    mov eax, msg2
    mov ebx, len_notfound
    mov ecx, SYS_WRITE
    mov edx, STDOUT
    int 80h
    exit

found:
    mov eax, msg1
    mov ebx, len_found
    mov ecx, SYS_WRITE
    mov edx, STDOUT
    int 80h

exit:
    mov ecx, SYS_EXIT
    int 0x80