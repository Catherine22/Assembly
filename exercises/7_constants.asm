STDOUT      equ 1
SYS_EXIT    equ 1
SYS_WRITE   equ 4

section .text
	global main

main:
	mov edx, len1
    mov ecx, msg1
    mov ebx, STDOUT  ;file descriptor (stdout)
    mov eax, SYS_WRITE  ;system call number (sys_write)
    int 0x80    ;call kernel

	mov edx, len2
    mov ecx, msg2
    mov ebx, STDOUT  ;file descriptor (stdout)
    mov eax, SYS_WRITE  ;system call number (sys_write)
    int 0x80    ;call kernel

	mov edx, len3
    mov ecx, msg3
    mov ebx, STDOUT  ;file descriptor (stdout)
    mov eax, SYS_WRITE  ;system call number (sys_write)
    int 0x80    ;call kernel

    mov eax, SYS_EXIT  ;system call number (sys_exit)
    int 0x80    ;call kernel

section .data
msg1 db "Hello, programmers!", 0xA, 0xD ;0xA -> new line
                                        ;0xD -> move the output cursor to the beginning of the current line
len1 equ $ - msg1
msg2 db "Welcome to the world of ",
len2 equ $ - msg2
msg3 db "Linux assembly programming!", 0xA, 0xD
len3 equ $ - msg3