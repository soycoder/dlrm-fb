#!/bin/bash -eEx
set -o pipefail

pip install --prefix=/usr/local --no-cache-dir --default-timeout=900 numpy
pip install --prefix=/usr/local --no-cache-dir --default-timeout=900 --pre torch -f https://download.pytorch.org/whl/nightly/cu113/torch_nightly.html
pip install --prefix=/usr/local "git+https://github.com/mlperf/logging.git@0.7.1"

# python3 -c "import torch;print(torch.cuda.is_available())"