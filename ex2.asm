global _start


section .data
	msg db "Hello, world!", 0x0a
	len equ $ - msg

section .text
_start:
	mov eax, 4   ; to denote that it's a sys_write system call
	mov ebx, 1   ; 1 is the file descriptor for stdout
	mov ecx, msg ; bytes to write
	mov edx, len ; number of bytes to write
	int 0x80     ; perform system call
	mov eax, 1   ; sys_exit system call
	mov ebx, 0   ; exit status is 0
	int 0x80
