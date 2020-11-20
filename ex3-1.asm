global _start

section .text
_start:
	mov ebx, 42 ; exit status is 42
	mov eax, 1  ; sys_exit system call
	jmp skip    ; jump to 'skip' label
	mov ebx, 13 ; exit status is 13, this line won't be executed
skip:
	int 0x80
