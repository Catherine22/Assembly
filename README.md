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
