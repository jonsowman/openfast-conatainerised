FROM ubuntu:20.04

# Required to prevent dpkg spawning interactive configuration scripts
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y \
    build-essential software-properties-common \
    cmake gcc gfortran git \
    libblas-dev liblapack-dev

# Set fortran compiler
ENV FC=/usr/bin/gfortran

# Fetch and build FAST
RUN git clone -b v2.4.0 https://github.com/openfast/openfast.git openfast 
WORKDIR /openfast
RUN mkdir build
WORKDIR /openfast/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Debug
RUN make -j4

# Print version
RUN /openfast/build/glue-codes/openfast/openfast -v

