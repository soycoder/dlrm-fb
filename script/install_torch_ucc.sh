#!/bin/bash -eEx
set -o pipefail

# UCC
echo "INFO: Install Torch-UCC (UCC version)"
export UCX_HOME=${UCX_INSTALL_DIR}
export UCC_HOME=${UCC_INSTALL_DIR}
export WITH_CUDA=${CUDA_HOME}
#export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/cuda-10.2/targets/x86_64-linux/include/
cd "${TORCH_UCC_INSTALL_DIR}"
python setup.py install bdist_wheel
pip list | grep torch
python -c 'import torch, torch_ucc'
