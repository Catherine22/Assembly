STDIN       equ 0
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    global x
    x:
        db 2
        db 4
        db 3
    sum:
        db 0

section .text
    global main

main:
    mov eax, 3  ;number of bytes to be summed
    mov ebx, 0  ;EBX will store the sum
    mov ecx, x  ;ECX will points to the current elements to be summed

top:
    add ebx, [ecx]
    add ecx, 1  ;moving the point to next element
    dec eax     ;decrement counter
    jnz top     ;if counter is not zero, then loop again

done:
    add ebx, '0'
    mov [sum], ebx ;done, store result in sum

display:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, sum
    mov edx, 1
    int 0x80

    mov eax, SYS_EXIT
    int 0x80