# Name

__ubuntu18-container-grpc-cpp__  
Container for running gRPC on Ubuntu 18.04  

# Overview
This is a container development environment for development using gRPC.  
The C++ and Python environments are built when the container image is built.  


# Installation

```bash
# When using a docker build.
$ docker build -t ubuntu18-container-grpc-cpp .
$ docker run -it --rm -v ${PWD}/:/home/project ubuntu18-container-grpc-cpp /bin/bash

# When using docker-compose.
$ docker-compose build
$ docker-compose run --rm dev
```
or  
Open the container from the remote container feature of VScode.  

# Demo

```bash
# Helloworld using C++ server and C++ client.
$ bash sample/hello_cpp_cpp.sh
Server listening on 0.0.0.0:50051
Greeter client received: Hello you

# How to run the sample code.
$ bash sample/build_sample.sh
$ sample/server/bin/server_sample & python3 sample/client/client_sample.py 10 5
Server listening on 0.0.0.0:55555
Add Result: y: 15
Sub Result: y: 5
Mul Result: y: 50
Div Result: y: 2
$ ps aux | grep server_sample | grep -v grep | awk '{ print "kill -9", $2 }' | sh
```

# Note

T.B.D.

# Author
- AIRO
- "https://twitter.com/AIRO28_"

# Licence

This repository is free.


