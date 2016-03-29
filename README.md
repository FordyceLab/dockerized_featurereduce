# Dockerized FeatureREDUCE

Docker is an open source tool that allows pieces of software to be installed in virtualized “containers.” This container holds all of the dependencies for the software, including operating system-level binaries. This container, specifically, houses all of the software and dependencies needed to run FeatureREDUCE from the Riley/Bussemaker labs. To use this container and the FeatureREDUCE software it houses, follow the drections below. The docker software for Mac and PC can be downloaded [here](https://www.docker.com/products/docker-toolbox). For linux distributions, follow the directions on the Docker website for your specific distribution. If you are using Ubuntu 14.04, I wrote a shell script to [install Docker automatically](https://github.com/FordyceLab/cloud_scripts).

## Setting up the Docker daemon

### Mac

On a Mac, you must set up the Docker daemon on top of a virtual machine. This can be accomplished using the `docker-machine` command as below:

```
docker-machine create -d virtualbox --virtualbox-memory <memory in kb> <name>
```

Where you can enter the desired amount of memory to allocate to the virtual machine and a name to identify the daemon. 

You can attach to this daemon with the command:

```
eval $(docker-machine env)
```

Note that although the Docker daemon only need be created once under most circumstances, you may need to reattach to the daemon each time you start a new terminal session. After reboots, daemons may need to be restarted. This can be done with:

```
docker-machine start <name>
```

For further help using docker-machine, consult the help page, which can be accesssed using the command `docker-machine -h` or `docker-machine <subcommand> -h`.

## Running the feturereduce container

Once the daemon is running you can run the featurereduce container using the following command:

```
docker run -it --rm tshimko/featurereduce
```

This command will run the `tshimko/featurereduce` container from Docker Hub as an interactive terminal (the `-it` options) and remove the container when you exit (the `--rm` option). Another useful feature of docker is the ability to map a directory on your machine (either local or cloud) to a directory inside the container. This way you can read and write between your machine and the conatiner, otherwise all data generated is lost and no data can be passed in. To map a data volume, use the -v option as below:

```
docker run -it --rm -v <local_dir>:<container_dir> tshimko/featurereduce
```

Where `local_dir` is the directory you want to map on the parental machine and `container_dir` is the directory to which you want to map inside the container. For example `~:~/data` would map my local home directory to a data subdirectory of home inside the container.