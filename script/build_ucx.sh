#!/bin/bash -eEx
set -o pipefail

echo "INFO: Build UCX"
cd "${SRC_DIR}/ucx"
"${SRC_DIR}/ucx/autogen.sh"
"${SRC_DIR}/ucx/contrib/configure-release-mt" --prefix="${UCX_INSTALL_DIR}" \
    --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu \
    --program-prefix= --disable-dependency-tracking \
    --exec-prefix=${UCX_INSTALL_DIR} --bindir=${UCX_INSTALL_DIR}/bin \
    --sbindir=${UCX_INSTALL_DIR}/sbin --sysconfdir=/etc --datadir=${UCX_INSTALL_DIR}/share \
    --includedir=${UCX_INSTALL_DIR}/include --libdir=${UCX_INSTALL_DIR}/lib64 \
    --libexecdir=${UCX_INSTALL_DIR}/libexec --localstatedir=/var \
    --sharedstatedir=/var/lib --mandir=${UCX_INSTALL_DIR}/share/man \
    --infodir=${UCX_INSTALL_DIR}/share/info --disable-optimizations \
    --enable-cma --with-cuda  \
    --with-verbs --with-cm --with-knem --with-rdmacm \
    --without-rocm --without-xpmem --without-ugni \
    --without-java  --with-cuda=/usr/local/cuda
make -j install
echo "${UCX_INSTALL_DIR}/lib" > /etc/ld.so.conf.d/ucx.conf
ldconfig
ldconfig -p | grep -i ucx | cat