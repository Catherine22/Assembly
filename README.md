# Assembly Exercise

## Set up environments

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

### Build and Execute

```shell
$./exec 2_hello.asm
```

## Registers

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

## Reversing Engineering with Radare 2

### Set up environments

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

### Getting started

```bash
$radare2 2_hello
```

### Cheat Sheet

-   any command + `?`: see help with any command. E.g. `a?`
-   debug commands
    -   `db <addr/sym>`: set a breakpoint
    -   `dc`: continue execution
    -   `ds`: step instructions and into calls
    -   `dso`: step instructions and over calls
    -   `dcr`: continue until a `rat` instruction
-   visual mode
    -   `V`: enter visual mode
    -   `?`: see keyboard shortcuts
    -   `:`: enter command mode, `<enter>` to exit command mode

## References

-   [programming from the ground up]
-   [assembly tutorial]
-   [Introduction To Reverse Engineering With Radare2]

[programming from the ground up]: https://www.amazon.co.uk/Programming-Ground-Up-Jonathan-Bartlett/dp/0975283847
[assembly tutorial]: https://www.tutorialspoint.com/assembly_programming/assembly_tutorial.pdf
[introduction to reverse engineering with radare2]: https://www.youtube.com/watch?v=LAkYW5ixvhg&ab_channel=TobalJackson
