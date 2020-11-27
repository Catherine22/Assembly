# Assembly Exercise

## Set up environments

1. Build the docker image

```bash
$docker build . -t assembly
```

2. Run the image in the background and share the workspace with the container

```bash
$docker run -d -it -v /Users/your_workspace/your_repo:/app/src --name assembly assembly
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

-   EAX: Primary accumulator
-   EBX: Base register, used in indexed addressing
-   ECX: Counter register, stores the loop count in iterative operations.
-   EDX: Data register, it is also used in input/output operations. It is also used with EAX register along
    with EDX for multiply and divide operations involving large values.

### System Calls

| EAX | Name      | EBX            | ECX           | EDX    |
| --- | --------- | -------------- | ------------- | ------ |
| 1   | sys_exit  | int            |               |        |
| 2   | sys_fork  | struct pt_regs |               |        |
| 3   | sys_read  | unsigned int   | char \*       | size_t |
| 4   | sys_write | unsigned int   | const char \* | size_t |
| 5   | sys_open  | const char \*  | int           | int    |
| 6   | sys_close | unsigned int   |               |        |

## References

-   [programming from the ground up]
-   [assembly tutorial]

[programming from the ground up]: https://www.amazon.co.uk/Programming-Ground-Up-Jonathan-Bartlett/dp/0975283847
[assembly tutorial]: tutorialspoint.com/assembly_programming/assembly_tutorial.pdf
