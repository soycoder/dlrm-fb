#!/bin/bash -eEx
set -o pipefail

# pip install --prefix=/usr/local --no-cache-dir --default-timeout=900 numpy
# pip install --prefix=/usr/local --no-cache-dir --default-timeout=900 --pre torch -f https://download.pytorch.org/whl/nightly/cu101/torch_nightly.html
pip install --prefix=/usr/local "git+https://github.com/mlperf/logging.git@0.7.1"

cd /tmp 
git clone https://github.com/pytorch/pytorch.git
cd /tmp/pytorch
git submodule sync --recursive
git submodule update --init --recursive
pip3 install -r requirements.txt
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

rm -rf /tmp/pytorch