#!/bin/bash -eEx
set -o pipefail

echo "INFO: Build OMPI"
OMPI_SRC_DIR="${SRC_DIR}/ompi"
cd "${OMPI_SRC_DIR}"
"${OMPI_SRC_DIR}/autogen.pl"
"${OMPI_SRC_DIR}/configure" --prefix=/opt/ompi --with-ucx=/opt/ucx --with-ucc=/opt/ucc
make -j install
echo "${OMPI_INSTALL_DIR}/lib" > /etc/ld.so.conf.d/ompi.conf
ldconfig
# ldconfig -p | grep -i libucc
