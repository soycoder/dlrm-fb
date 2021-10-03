#!/bin/bash -eEx
set -o pipefail

pip install --default-timeout=900 numpy
pip install --default-timeout=900 --pre torch -f https://download.pytorch.org/whl/nightly/cu101/torch_nightly.html
pip install "git+https://github.com/mlperf/logging.git@0.7.1"