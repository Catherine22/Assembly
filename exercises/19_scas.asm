STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    my_string db "password", 0
    len equ $- my_string
    msg_found db "found!", 0xA
    len_found equ $- msg_found
    msg_notfound db "not found!", 0xA
    len_notfound equ $- msg_notfound

section .text
    global main

main:
    mov ecx, len
    mov edi, my_string
    mov al, 'a'
    cld
    repne scasb
    je found    ;when found

    ;if not found then the following code
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg_notfound
    mov edx, len_notfound
    int 80h

    mov eax, SYS_WRITE
    mov ebx, STDIN
    int 0x80

    found:
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, msg_found
        mov edx, len_found
        int 80h