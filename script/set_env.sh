#!/bin/bash

export SRC_DIR=/home/projects/50000043/apacsc29/.src
export INSTALL_DIR=/home/projects/50000043/apacsc29/.local

export LD_LIBRARY_PATH=$INSTALL_DIR/lib:$INSTALL_DIR/lib64:/usr/lib:/usr/lib64:/lib:/lib64

export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH

# GNU - GCC
# alias gcc="$INSTALL_DIR/bin/gcc"
# alias g++="$INSTALL_DIR/bin/g++"
# CC=$INSTALL_DIR/bin/gcc
# CXX=$INSTALL_DIR/bin/g++

# OpenSSL
export PATH=$INSTALL_DIR/openssl/bin:$PATH
export LD_LIBRARY_PATH=$INSTALL_DIR/openssl/lib:$LD_LIBRARY_PATH

# Python 3.8.1
export PATH=$INSTALL_DIR/bin:$PATH

# CMake 3.20.4
export PATH=$INSTALL_DIR/cmake/bin:$PATH


## Set Environment
UCX_GITHUB_URL=https://github.com/openucx/ucx.git
UCX_BRANCH=master
export UCX_INSTALL_DIR=${INSTALL_DIR}/ucx
UCX_BUILD_TYPE=release-mt
# 
UCC_GITHUB_URL=https://github.com/openucx/ucc.git
UCC_BRANCH=master
export UCC_INSTALL_DIR=${INSTALL_DIR}/ucc
# 
OMPI_GITHUB_URL=https://github.com/open-mpi/ompi.git
OMPI_BRANCH=v4.1.1
export OMPI_INSTALL_DIR=${INSTALL_DIR}/ompi
# 
TORCH_UCC_GITHUB_URL=https://github.com/facebookresearch/torch_ucc.git
TORCH_UCC_BRANCH=main
export TORCH_UCC_INSTALL_DIR=${INSTALL_DIR}/torch_ucc