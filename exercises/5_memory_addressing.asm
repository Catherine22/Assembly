section .text
	global main

main:
    ;1. writing the name "Zara Ali"
	mov edx, len
    mov ecx, name
    mov ebx, 1  ;file descriptor (stdout)
    mov eax, 4  ;system call number (sys_write)
    int 0x80    ;call kernel

    ;2. changing the name to "Naha Ali"
    mov [name], dword "Naha"

    ;3. writing the name "Naha Ali"
    mov edx, len
    mov ecx, name
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;4. terminating
    mov eax, 1  ;system call number (sys_exit)
    int 0x80    ;call kernel

section .data
name db "Zara Ali", 0xA
len equ $ - name ;length of our dear string