STDIN       equ 0
STDOUT      equ 1
STDERR      equ 2
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

section .data
    msg_prompt db "Enter INT1<OP>INT2 (E.g. 5+7):"
    len_prompt equ $- msg_prompt
    msg_res db "The result is: ", 0xA
    len_res equ $- msg_res

    ;error messages
    err_msg_invalid_operand db "Invalid operand", 0xA
    len_err_msg_invalid_operand equ $- err_msg_invalid_operand
    err_msg_invalid_operator db "Invalid operator", 0xA
    len_err_msg_invalid_operator equ $- err_msg_invalid_operator
    err_msg_invalid_inputs db "Invalid inputs", 0xA
    len_err_msg_invalid_inputs equ $- err_msg_invalid_inputs

section .bss
    exp resb 4
    exp_len rest 4
    max_exp_len resb 100
    res resb 2
    res_len rest 2
    max_res_len resb 100

section .text
    global main

main:
    ;print welcome message
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg_prompt
    mov edx, len_prompt
    int 0x80

    ;read stdin
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, exp
    mov edx, max_exp_len
    int 0x80

    mov [exp_len], eax
    
    ;verify inputs
    

    ;result message
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg_res
    mov edx, len_res
    int 0x80

    ;calculation

    ;print the result
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, exp
    mov edx, [exp_len]
    int 0x80

    ;terminate the programme
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

invalid_inputs:
    mov rdi, err_msg_invalid_inputs
    call handle_error

handle_error:
	; push rdi
	; call strlen
	; mov rdi, STDERR
	; pop rsi
	; mov rdx, rax
	; mov rax, SYS_WRITE
    ; int 0x80

    mov eax, SYS_EXIT
    int 0x80
	ret

strlen:
	push rdi
	sub	ecx, ecx
	mov	rdi, [esp+8]
	not	ecx
	sub	al, al
	cld
    repne scasb
	not	ecx
	pop	rdi
	lea	eax, [ecx-1]
	ret