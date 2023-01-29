
# Install Dependency on DGX-Environment

## Set Environment
```
export SRC_DIR=/home/projects/50000043/apacsc29/.src
export INSTALL_DIR=/home/projects/50000043/apacsc29/.local.dgx

mkdir -p $SRC_DIR
mkdir -p $INSTALL_DIR

```

## Install GNU gcc-g++ 7.3.0
```
# https://linuxhostsupport.com/blog/how-to-install-gcc-on-ubuntu-18-04/
>$ cd $SRC_DIR && \
wget http://167.71.205.129/tools/gcc-7.3.0.tar.gz && \
tar zxf gcc-7.3.0.tar.gz && \
cd gcc-7.3.0 && \
./contrib/download_prerequisites && \
./configure -v --build=x86_64-linux-gnu --host=x86_64-linux-gnu \
--target=x86_64-linux-gnu --prefix=$INSTALL_DIR/gcc-7.3 --disable-multilib --enable-checking=release --enable-languages=c,c++,fortran \
 && \
make -j $(nproc) && \
make install

 export PATH=$INSTALL_DIR/gcc-7.3 /bin:$PATH
 export LD_LIBRARY_PATH=$INSTALL_DIR/gcc-7.3 /lib:$INSTALL_DIR/gcc-7.3 /lib64:$LD_LIBRARY_PATH
```

## Install OpenSSL
```
>$ cd $SRC_DIR && \
wget http://167.71.205.129/tools/openssl-1.1.1l.tar.gz && \
tar zxf openssl-1.1.1l.tar.gz && \
cd openssl-1.1.1l && \
./config --prefix=$INSTALL_DIR/openssl --openssldir=$INSTALL_DIR/openssl no-ssl2 CC=$INSTALL_DIR/bin/gcc && \
make -j $(nproc)  && \
make install
```
```
 export LIBRARY_PATH=/usr/lib/x86_64-linux-gnu

 export LD_LIBRARY_PATH=$INSTALL_DIR/lib:$INSTALL_DIR/lib64:/usr/lib:/usr/lib64:/lib:/lib64

 export PATH=$INSTALL_DIR/openssl/bin:$PATH
 export LD_LIBRARY_PATH=$INSTALL_DIR/openssl/lib:$LD_LIBRARY_PATH
 # export LDFLAGS="-L $INSTALL_DIR/openssl/lib -Wl,-rpath,$INSTALL_DIR/openssl/lib"
```


## Install Python
```
>$ VERSION=3.8.1
>$ wget https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz && \
tar -xf Python-${VERSION}.tgz && \
cd Python-${VERSION} && \
./configure --enable-optimizations \
--with-openssl=$INSTALL_DIR/openssl \
LDFLAGS=-L$INSTALL_DIR/libffi3.2.1/lib64 \
PKG_CONFIG_PATH=$INSTALL_DIR/libffi3.2.1/lib/pkgconfig \
--enable-shared \
--prefix=$INSTALL_DIR/python \
CXX=$INSTALL_DIR/bin/g++ \
CC=$INSTALL_DIR/bin/gcc && \
make -j $(nproc) && \
make install

 export PATH=$INSTALL_DIR/python/bin:$PATH
 export LD_LIBRARY_PATH=$INSTALL_DIR/python/lib:$LD_LIBRARY_PATH

# Check your Python
>$ python3 --version
    Python 3.8.1
>$ pip3 --version
    pip 19.2.3 from $INSTALL_DIR/lib/python3.8/site-packages/pip (python 3.8)

# Update pip
>& pip3 install --upgrade pip
    pip 21.3 from $INSTALL_DIR/lib/python3.8/site-packages/pip (python 3.8)
```

# DLRM
## Set Environment
```
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
```
## CMake
```
>$ mkdir -p $INSTALL_DIR/cmake
>$ cd $SRC_DIR && \
wget http://167.71.205.129/tools/cmake-3.20.4-linux-x86_64.sh && \
chmod +x cmake-3.20.4-linux-x86_64.sh && \
$SRC_DIR/cmake-3.20.4-linux-x86_64.sh --skip-license --prefix=$INSTALL_DIR/cmake

>$ export PATH=$INSTALL_DIR/cmake/bin:$PATH

```

## Git clone 
```
mkdir -p ${SRC_DIR}/ucx && \
git clone --recursive ${UCX_GITHUB_URL} ${SRC_DIR}/ucx && \
cd ${SRC_DIR}/ucx && \
git checkout ${UCX_BRANCH}

mkdir -p ${SRC_DIR}/ucc && \
git clone --recursive ${UCC_GITHUB_URL} ${SRC_DIR}/ucc && \
cd ${SRC_DIR}/ucc && \
git checkout ${UCC_BRANCH}

mkdir -p ${SRC_DIR}/ompi && \
git clone --recursive ${OMPI_GITHUB_URL} ${SRC_DIR}/ompi && \
cd ${SRC_DIR}/ompi && \
git checkout ${OMPI_BRANCH}

git clone https://github.com/soycoder/dlrm-fb.git ${SRC_DIR}/devel && \
cd ${SRC_DIR}/devel && \
git checkout devel

```


```
# ${SRC_DIR}/devel/script/build_ucx.sh
echo "INFO: Build UCX"
cd "${SRC_DIR}/ucx"
"${SRC_DIR}/ucx/autogen.sh"
CC=$INSTALL_DIR/bin/gcc \
CXX=$INSTALL_DIR/bin/g++ \
"${SRC_DIR}/ucx/contrib/configure-release-mt" --prefix="${UCX_INSTALL_DIR}" \
    --enable-cma --with-cuda  \
    --with-verbs \
    --without-rocm --without-xpmem --without-ugni \
    --without-java  --with-cuda=/home/app/cuda10.1 && \
make -j install
echo "${UCX_INSTALL_DIR}/lib" > /etc/ld.so.conf.d/ucx.conf
ldconfig
PATH=${UCX_INSTALL_DIR}/bin:${PATH}

```


# TORCH - UCC
echo "INFO: Install Torch-UCC (UCC version)"
export UCX_HOME=${UCX_INSTALL_DIR}
export UCC_HOME=${UCC_INSTALL_DIR}
export WITH_CUDA=${CUDA_HOME}
cd "${TORCH_UCC_INSTALL_DIR}"
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/app/cuda92/include/
python3 setup.py install bdist_wheel
pip list | grep torch
python -c 'import torch, torch_ucc'