#!/bin/bash -eEx
set -o pipefail

echo "INFO: Build UCX"
cd "${SRC_DIR}/ucx"
"${SRC_DIR}/ucx/autogen.sh"
"${SRC_DIR}/ucx/contrib/configure-release-mt" --prefix="${UCX_INSTALL_DIR}" \
    --enable-cma  \
    --with-verbs --with-cm \
    --without-rocm --without-xpmem --without-ugni \
    --without-java 
make -j install
echo "${UCX_INSTALL_DIR}/lib" > /etc/ld.so.conf.d/ucx.conf
ldconfig
# ldconfig -p | grep -i ucx
