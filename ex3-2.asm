global _start

section .text
_start:
	mov ecx, 101 ; set ecx to 101
	mov ebx, 42  ; exit status is 42
	mov eax, 1   ; sys_exit system call
	cmp ecx, 100 ; compare ecx to 100
	jl less      ; jump if ecx is less than 100
	mov ebx, 13  ; exit status is 13
less:
	int 0x80
