section .text
	global main

main:
	mov edx, len
    mov ecx, msg
    mov ebx, 1  ;file descriptor (stdout)
    mov eax, 4  ;system call number (sys_write)
    int 0x80    ;call kernel

    mov eax, 1  ;system call number (sys_exit)
    int 0x80    ;call kernel

section .data
msg db "Hello, world!", 0xa
len equ $ - msg ;length of our dear string