;The data section is used for declaring constants. This data does not change at runtime
section .data
    userMsg db "Please enter a number (5 digits max): "
    lenUserMsg equ $-userMsg
    dispMsg db "You have entered: "
    lenDispMsg equ $-dispMsg

;The bss section is used for declaring variables
section .bss    ;uninitialised data
    num resb 5

;The text section is used for keeping the actual code
section .text
    global main
    main:
        ;User prompt
        mov eax, 4  ;system call number (sys_write)
        mov ebx, 1  ;file descriptor (stdout)
        mov ecx, userMsg
        mov edx, lenUserMsg
        int 0x80

        ;read and store the user input
        mov eax, 3  ;system call number (sys_read)
        mov ebx, 2
        mov ecx, num
        mov edx, 5  ;5 bytes (numeric, 1 for sign) of that information
        int 0x80

        ;output the message "The entered number is: "
        mov eax, 4  ;system call number (sys_write)
        mov ebx, 1  ;file descriptor (stdout)
        mov ecx, dispMsg
        mov edx, lenDispMsg
        int 0x80

        ;output the number entered
        mov eax, 4
        mov ebx, 1
        mov ecx, num
        mov edx, 5  ;5 bytes (numeric, 1 for sign) of that information
        int 0x80

        ;exit
        mov eax, 1
        mov ebx, 0
        int 0x80



