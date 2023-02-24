Troubleshooting
===============


- [[docker] localstack status cmd stalling](#ts1)




<div id='ts1'/>

# [docker] localstack status cmd stalling #

1. get docker context
    ```sh
    docker context list
    ```
    and look for docker endpoint value of `default`

2. set DOCKER_HOST value
    ```sh
    export DOCKER_HOST=<docker endpoint value>
    ```
3. running `localstack status` should no longer stall