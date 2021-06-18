# '''Dockerfile for Ubuntu18.04 + gRPC'''

# Set Ubuntu 18.04 as the base image.
FROM ubuntu:18.04

# Disable interactive installation.
ENV DEBIAN_FRONTEND=noninteractive

# Describe the packages to be installed at build time.
RUN apt-get update && apt-get upgrade -y && \
    apt install -y wget \
    git \
    clang \
    ca-certificates \
    build-essential \
    libssl-dev \
    make \
    autoconf \
    automake \
    pkg-config \
    libtool \
    golang \
    curl \
    g++ \
    unzip

# Set time zone to Asia/Tokyo.
ENV TZ=Asia/Tokyo

# gRPC installation destination environment variable.
# ENV MY_INSTALL_DIR /root/.local
# ENV PATH $PATH:$MY_INSTALL_DIR/bin
# ENV PATH $PATH:/grpc/cmake/build
# ENV PATH $PATH:/grpc/cmake/build/third_party/protobuf
ENV MY_INSTALL_DIR /usr/local
RUN mkdir -p ${MY_INSTALL_DIR}

# Install CMake version 3.19.6.
RUN wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.19.6/cmake-3.19.6-Linux-x86_64.sh && \
    mkdir -p ${MY_INSTALL_DIR} && \
    sh cmake-linux.sh -- --skip-license --prefix=${MY_INSTALL_DIR} && \
    rm cmake-linux.sh

# Clone gRPC version 1.35.0.
RUN git clone -b v1.35.0 https://github.com/grpc/grpc && \
    cd grpc && \
    git submodule update --init --recursive

# Build third-party packages that have dependencies.
RUN cd /grpc/third_party/cares/cares && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          ../.. && \
    make -j4 install && \
    cd /grpc/third_party/zlib && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_BUILD_TYPE=Release  \
          ../.. && \
    make -j4 install && \
    cd /grpc/third_party/protobuf && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -Dprotobuf_BUILD_TESTS=OFF \
          -DCMAKE_BUILD_TYPE=Release \
          .. && \
    make -j4 install

# Build gRPC.
RUN cd /grpc && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DgRPC_INSTALL=ON \
          -DgRPC_BUILD_TESTS=OFF \
          -DgRPC_CARES_PROVIDER=package \
          -DgRPC_PROTOBUF_PROVIDER=package \
          -DgRPC_SSL_PROVIDER=package \
          -DgRPC_ZLIB_PROVIDER=package \
          -DCMAKE_INSTALL_PREFIX=${MY_INSTALL_DIR} \
          ../.. && \
    make -j4 install && \
    ldconfig

# Build the HelloWorld sample code.
RUN cd /grpc/examples/cpp/helloworld && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_PREFIX_PATH=${MY_INSTALL_DIR} \
          ../.. && \
    make -j

# Install the libraries required for python3.6 and gRPC.
RUN apt-get install -y python3.6 \
    python3-pip \
    python3-dev \
    python3-setuptools && \
    pip3 install -U pip && \
    pip3 install grpcio grpcio-tools googleapis-common-protos

# Setting the Japanese Locale.
RUN apt install -y locales && \
    locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

# Metadata description.
LABEL maintainer="https://twitter.com/AIRO28_" \
    version="1.0" \
    description="Ubuntu18.04 container with gRPC"

# Change the working directory.
WORKDIR /home/project/

# Instructions to be executed at container startups.
CMD ["/bin/bash"]