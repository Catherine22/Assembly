# Assembly & Reverse Engineering

Learning assembly from scratch including:

- Assembly programming
- Reverse and analyse binary files

## Navigation

[Assembly Programming](#assembly-programming)

- [Environments & Tools](#environments--tools-1)
- [Set Up Environments](#set-up-environments-1)
- [Memory Allocation](#memory-allocation)
- [Registers](#registers)
- [System Calls](system-calls)
- [Function Calls](function-calls)
- [Instructions](#instructions)
- [Debug](#debug)

[Reversing Engineering with Radare 2](reversing-engineering-with-radare2)

- [Environments & Tools](#environments--tools-2)
- [Set Up Environments](#set-up-environments-2)
- [Assembly to C](#assembly-to-c)
- [Useful Commands](#useful-command)

[References](#references)

# Assembly Programming

## Environments & Tools

- x86_64 architecture

- Linux CentOS 7 with nasm

## Set Up Environments

NOTICE, the following docker image supports x86_64 architecture.

1. Build the docker image

```bash
$docker build . -t assembly
```

2. Run the image in the background and share the workspace with the container

```bash
$docker run -d -it -v $(pwd):/app/src --name assembly assembly
```

3. Run the bash in the container

```bash
$docker exec -it assembly /bin/bash
```

4. build and execute

```shell
$./exec 2_hello.asm
```

## Memory Allocation

- Define constants or functions

```assembly
section .data
	somePtr:
    dd constant0
	someFunc:
		...
		ret
```

- Access constants

```assembly
mov ... DWORD[somePtr] ...
```

- Table for generating constants

  | Instruction | C++   | Access         | **Register** | Bits | Bytes |
  | ----------- | ----- | -------------- | ------------ | ---- | ----- |
  | dq 0x3      | long  | QWORD[somePtr] | r _ _        | 64   | 8     |
  | dd 0x3      | int   | DWORD[somePtr] | e _ _        | 32   | 4     |
  | dw 0x3      | short | WORD[somePtr]  | _ _          | 16   | 2     |
  | db 0x3      | char  | BYTE[somePtr]  | _ l          | 8    | 1     |

- Example 1 - Load a statically allocated integer from memory

```assembly
	mov eax, DWORD [myInt]	;copy myInt into eax
	ret

section .data
myInt:
	dd 0xa3a2a1a0	;"data DWORD" containing this value
```

- Example 2 - Copy a pointer value into a register

```assembly
	mov rdx, myIntPtr	;copy the address myIntPtr into rdx (like C++: p=someIntPtr;)
	mov eax, DWORD [rdx]	;read memory rdx points to (like C++: return *p;)
	ret

section .data
myIntPtr:	; A place in memory, where we're storing an integer
	dd 123	; "data DWORD", our integer
```

- Example 3 - A 4-digit array

```assembly
	mov eax, DWORD [arr+4*2] ; read arr[2]
	ret 

section .data
arr:  ;An integer array
	dd 100 ;"data DWORD", arr[0]
	dd 101 ;arr[1]
	dd 102 ;arr[2]
	dd 103 ;arr[3]
```

- Example 4 - String

```assembly
movzx eax, BYTE[myStr + 2] ;read this byte into eax
ret

section .data
myStr:
	db "woa"	;= db 'w','o','a'
						;= db 'woa'
						;= db 'w' db 'o' db 'a'
```

- Example 5 - update data

```assembly
mov DWORD[func+1],7 ;overwrite constant loaded by first, 0xb8 instruction
call func
ret

section .data
	func:
		mov eax,2 ;<- modified at runtime!
		ret
```



## Registers

| 64-bit   | 32-bit     | 16-bit     | 8-bit      |
| -------- | ---------- | ---------- | ---------- |
| rax      | eax        | ax         | ah and al  |
| rbx      | ebx        | bx         | bh and bl  |
| rcx      | ecx        | cx         | ch and cl  |
| rdx      | edx        | dx         | dh and dl  |
| rsp      | esp        | sp         | spl        |
| rbp      | ebp        | bp         | bpl        |
| rsi      | esi        | si         | sil        |
| rdi      | edi        | di         | dil        |
| r8 - r15 | r8d - r15d | r8w - r15w | r8b - r15b |

For example:

```
0x1122334455667788
  ================ rax (64 bits)
          ======== eax (32 bits)
              ====  ax (16 bits)
              ==    ah (8 bits)
                ==  al (8 bits)
```

### CPU Registers

### Instruction Pointer

-   rip: what executes next

### General Purpose

-   eax: Primary accumulator, **_it's usually reserved for the return value_**
-   ebx: Base register, used in indexed addressing.
-   ecx: Counter register, stores the loop count in iterative operations.
-   edx: Data register, it is also used in input/output operations. It is also used with eax register along
    with edx for multiply and divide operations involving large values.

### Stack

-   rsp: stack pointer (top)
-   rbp: base pointer (bottom)

### Data

-   rsi: source index
-   rdi: destination index

### Other

-   r8 - r15

## System Calls

-   rax: syscall number
-   rdi: arg0
-   rsi: arg1
-   rdx: arg2
-   r10-r8-r9: arg3-arg5

| EAX | Name      | EBX            | ECX           | EDX    |
| --- | --------- | -------------- | ------------- | ------ |
| 1   | sys_exit  | int            |               |        |
| 2   | sys_fork  | struct pt_regs |               |        |
| 3   | sys_read  | unsigned int   | char \*       | size_t |
| 4   | sys_write | unsigned int   | const char \* | size_t |
| 5   | sys_open  | const char \*  | int           | int    |
| 6   | sys_close | unsigned int   |               |        |

## Function Calls

-   rax: **_return value_**
-   rdi: arg0
-   rsi: arg1
-   rdx: arg2
-   **_rcx-r8-r9_**: arg3-arg5

## Instructions

-   CPU flags: ZF(Zero Flag): cmp, jump, test
-   Stack: push, pop, call, leave, rat
-   Control flow: call, jump

## Debug

Run the executive file with `gdb`

```shell
$gdb 2_hello
```

### GDB Commands

-   list: show the code
-   list x,y: show the code from line x to y

# Reversing Engineering with Radare 2

## Environments & Tools

- x86_64 architecture
- Linux Debian 10 with radare2
- macOS with cutter (Optional, cutter is basically a GUI of radare2)

## Set Up Environments

1. Build the docker image

```bash
$docker build . -t radare2
```

2. Run the image in the background and share the workspace with the container

```bash
$docker run -d -it -v $(pwd):/app/src --name radare2 radare2
```

3. Run the bash in the container

```bash
$docker exec -it radare2 /bin/bash
```

4. Get started by [crackmes]

## Assembly to C

- Stack

```assembly
push rbp 			;stash old value of rbp on the stack
mov rbp, rsp	;rbp == stack pointer at the start of function
sub rsp, 1000	;make some room on the stack
```

- Function and variables

```assembly
	mov eax, 3	;int x = 3
	jmp f				;goto f
	mov eax, 0	;<- never executed

f:						;f
	ret					;return x
```

- `call` vs `jmp`

```assembly
	mov edi,1000
	call f
	add eax, 7	;will be executed when f is done
	ret

f:
	mov eax, edi ;copy our first parameter into eax (to be returned)
	ret ;go back to where the function is called
```

```assembly
	mov edi,1000
	jmp f
	add eax, 7 ;<- never executed
	ret

f:
	mov eax, edi ;copy our first parameter into eax (to be returned)
	ret ;go back to main
```

- More control flow

```assembly
	mov eax, 3	;int x = 3
	cmp eax, 4	;how does eax compare to 4?
	je f				;jump to f if it's equal
```

```assembly
	mov eax, 3	;int x = 3
	cmp eax, 4	;how does eax compare to 4?
	jl f				;jump to f if eax is less than 4
```

```assembly
cmp eax, 3	;subtracts 3 from eax value, but it won't change eax
sub eax, 3	;subtracts 3 from eax value, but it will change eax
```

- Signed & unsigned value

  - Use `jg` or `jl` to compare 2 signed values
  - Use `ja` or `jb` to compare 2 unsigned values
  - To compare a signed value to a unsigned value

  | English              | Less Than | Less or Equal | Equal    | Greater or Equal | Greater Than | Not Equal  |
  | -------------------- | --------- | ------------- | -------- | ---------------- | ------------ | ---------- |
  | C/C++                | <         | <=            | ==       | >=               | >            | !=         |
  | Assembly  (signed)   | jl        | jle           | je or jz | jge              | jg           | jne or jnz |
  | Assembly  (unsigned) | jb        | jbe           | je or jz | jae              | ja           | jne or jnz |

## Useful Commands

- Get started

```bash
$ r2 -d ./crackme0x00 	# analyse a binary file with r2 in debug mode
	> aa									# or aaa
	> pdf@PROCEDURE_NAME 	# any procedure you want to focus on, e.g. main.
```

- Type commands

```bash
> :			# type : to enter command mode
> enter # quit the command mode
```

- Add a breakpoint and continue running

```bash
> db ADDRESS 	# E.g. db 0x004006e5
> dc 					# continue running
> s 					# step
> S 					# step over
> ood 				# restart execution
```

- Switch to visual mode

```bash
> v # switch to visual mode
> p # switch to different panel
> q # leave the visual mode.
```

- Print a value at an address or register

```bash
> ? REG_NAME 					# e.g. ? rax
> dr?REG_NAME 				# e.g. dr?rax
> px @REG_NAME 				# e.g. px @rax
> px BYTES @REG_NAME 	# e.g. px 4 @rax
```

- Help

```bash
> d? # print the manual of debug commands
```

- Quit

```bash
> q
```

A simple debug flow could be

1. Execute and analyse the binary file, and check what main procedure does.

```bash
$ r2 -d ./crackme0x00
> aa
> pdf@main
```

2. Check the details of key procedures.

```bash
> pdf@PROC_NAME
```

3. Add breakpoints and continue debugging

```bash
> db ADDRESS 	# E.g. db 0x004006e5
>	db ADDRESS 	# E.g. db 0x004007e5
```

4. Check all the breakpoints and remove unwanted ones.

```assembly
> db
> db -ADDRESS 	# E.g. db 0x004007e5
```

5. Execute the programme step by step, or jump to next breakpoint.

```bash
> dc						# jump to next breakpoint
> V							# switch to the visual mode to better check the values of registers
> s							# move on to next line
> S							# step over next line
```

5. Restart the programme if the process is finished.

```bash
> ood
> q							# exit the visual mode
```

# References

-   [Programming from the Ground Up]
-   [Assembly Tutorial]
-   [Introduction To Reverse Engineering With Radare2]
-   [The Official Radare2 Book]
-   [2010 CS 301 - Assembly Language]



[Programming from the Ground Up]: https://www.amazon.co.uk/Programming-Ground-Up-Jonathan-Bartlett/dp/0975283847
[Assembly Tutorial]: https://www.tutorialspoint.com/assembly_programming/assembly_tutorial.pdf
[Introduction To Reverse Engineering With Radare2]: https://www.youtube.com/watch?v=LAkYW5ixvhg&ab_channel=TobalJackson
[crackmes]: https://book.rada.re/crackmes/ioli/ioli_0x00.html
[The Official Radare2 Book]: https://book.rada.re/
[2010 CS 301 - Assembly Language]: https://www.cs.uaf.edu/2010/fall/cs301/

