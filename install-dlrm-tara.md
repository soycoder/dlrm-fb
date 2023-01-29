
# Install Dependency on DGX-Environment

## Set Environment
```
export SRC_DIR=/tarafs/data/project/proj5008-roopai/.src.dgx
export INSTALL_DIR=/tarafs/data/project/proj5008-roopai/.local.dgx

module purge
module load CUDA/10.1.243-GCC-8.3.0
module load OpenMPI/3.1.4-GCC-8.3.0

mkdir -p $SRC_DIR
mkdir -p $INSTALL_DIR

```

## Install Python
```
>$ VERSION=3.8.1
>$ wget https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz && \
tar -xvf Python-${VERSION}.tgz && \
cd Python-${VERSION} && \
./configure --enable-optimizations \
LDFLAGS=-L$INSTALL_DIR/libffi3.2.1/lib64 \
PKG_CONFIG_PATH=$INSTALL_DIR/libffi3.2.1/lib/pkgconfig \
--enable-shared \
--prefix=$INSTALL_DIR/python \
CXX=/tarafs/utils/modules/software/GCCcore/8.3.0/bin/g++ \
CC=/tarafs/utils/modules/software/GCCcore/8.3.0/bin/gcc && \
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


