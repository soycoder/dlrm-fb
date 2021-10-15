#!/bin/bash -eEx
set -o pipefail

mkdir -p /tools
cd /tools 
git clone https://github.com/pytorch/pytorch.git
cd /tools/pytorch
git submodule sync --recursive
git submodule update --init --recursive
git checkout v1.9.1
pip install -r requirements.txt
export TORCH_CUDA_ARCH_LIST="7.0 8.0+PTX"
export USE_GLOO=1
export USE_DISTRIBUTED=1
export USE_OPENCV=0
export USE_CUDA=1
export USE_NCCL=1
export USE_MKLDNN=0
export BUILD_TEST=0
export USE_FBGEMM=0
export USE_NNPACK=0
export USE_QNNPACK=0
export USE_XNNPACK=0
export USE_KINETO=1
export MAX_JOBS=$(($(nproc)-1))
python setup.py install

rm -rf /tools/pytorch