STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    msg db "The sum is: ", 0xA
    len equ $- msg
    num1 db "12345"
    num2 db "54321"
    sum db "     "

section .text
    global main

main:
    mov esi, 4  ;pointint to the right most digit
    mov ecx, 5  ;num of digits
    clc

add_loop:
    mov al, [num1 + esi]
    adc al, [num2 + esi]
    aaa
    pushf
    or al, 30h
    popf
    mov [sum + esi], al
    dec esi
    loop add_loop
    mov edx, len
    mov ecx, msg
    mov ebx, STDOUT
    mov eax, SYS_WRITE
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, sum
    mov edx, 5
    int 0x80

    mov eax, SYS_EXIT
    int 0x80
