section .text
	global main

main:
	mov edx, len
    mov ecx, msg
    mov ebx, 1  ;file descriptor (stdout)
    mov eax, 4  ;system call number (sys_write)
    int 0x80    ;call kernel

	mov edx, 9
    mov ecx, stars
    mov ebx, 1  ;file descriptor (stdout)
    mov eax, 4  ;system call number (sys_write)
    int 0x80    ;call kernel
    mov eax, 1  ;system call number (sys_exit)
    int 0x80    ;call kernel

section .data
msg db "Displaying 9 stars", 0xa
len equ $ - msg
stars times 9 db "*"