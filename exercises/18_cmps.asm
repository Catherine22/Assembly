STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    s1 db "password", 0
    len_s1 equ $- s1
    s2 db "passw0rd", 0
    len_s2 equ $- s2
    msg1 db "Strings are equal", 0xA
    len_m1 equ $- msg3
    msg2 db "Strings are not equal", 0xA
    len_m2 equ $- len4

section .text
    global main

main:
    mov esi, s1
    mov edi, s2
    mov ecx, len_s2
    cld
    repe cmpsb  ;comparing two strings (for bytes - CMPSB, for words - CMPSW, for doublewords - CMPSD)
    jecxz equal ;jump when ecx is zero

    ;If not equal then the following code
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg2
    mov edx, len_m2
    int 80h
    jump exit

equal:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len_m1
    int 80h

exit:
    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h