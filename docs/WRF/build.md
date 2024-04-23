# WRF 编译安装

[Compiling WRF](https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php)

!!! warning "对于 intel 编译器(icc icpc ifort)，需要对 configure.wrf/configure.wps 进行修改"

    ```diff
    - DM_FC           =       mpif90
    - DM_CC           =       mpicc -cc=$(SCC)
    + DM_FC           =       mpiifort
    + DM_CC           =       mpiicc
    ```

## CentOS GCC update

```bash
yum install centos-release-scl
yum install devtoolset-8
# shell 切换 GCC 8
source /opt/rh/devtoolset-8/enable
# or
#scl enable devtoolset-8 bash
```

## config

```bash
# WARNING: CentOS7 不要用自带的 GCC 4.8.5 编译，要用个更高的版本

# intel WRF 依赖库路径
export WRF_LIBRARY=/home/ahri/apps

export CC=gcc
export CXX=g++
export FC=gfortran
export FCFLAGS=-m64
export F77=gfortran
export FFLAGS=-m64

export LD_LIBRARY_PATH=$WRF_LIBRARY/lib
export LIBRARY_PATH=$WRF_LIBRARY/lib
export PATH=$PATH:$WRF_LIBRARY/bin
export NETCDF=$WRF_LIBRARY
export JASPERLIB=$WRF_LIBRARY/lib
export JASPERINC=$WRF_LIBRARY/include
```

## WRF deps

### 1. zlib

```shell
wget https://github.com/madler/zlib/releases/download/v1.2.13/zlib-1.2.13.tar.gz
./configure --prefix=$WRF_LIBRARY
make
make install
```

### 2. szip

```shell
wget https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz
./configure --enable-shared --prefix=$WRF_LIBRARY
make
make install
```

### 3. hdf5(依赖 zlib szip)

```shell
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz
./configure --enable-shared --enable-fortran --with-zlib=$WRF_LIBRARY --with-szlib=$WRF_LIBRARY --prefix=$WRF_LIBRARY
make
make install
```

### 4. udunits

```shell
wget https://downloads.unidata.ucar.edu/udunits/2.2.28/udunits-2.2.28.tar.gz
# CentOS
yum install expat*
# Ubuntu
sudo apt-get install libexpat1-dev
./configure --enable-shared --prefix=$WRF_LIBRARY
make
make install
```

### 5. netcdf C/C++/Fortran(依赖 hdf5 udunits)

```shell
# CentOS
yum install libxml2-devel m4 curl-devel

wget https://downloads.unidata.ucar.edu/netcdf-c/4.8.1/netcdf-c-4.8.1.tar.gz
./configure --enable-shared --enable-netcdf4 CPPFLAGS=-I$WRF_LIBRARY/include LDFLAGS=-L$WRF_LIBRARY/lib --prefix=$WRF_LIBRARY
make
make install

wget https://downloads.unidata.ucar.edu/netcdf-fortran/4.5.3/netcdf-fortran-4.5.3.tar.gz
./configure --enable-shared --enable-netcdf4 CPPFLAGS=-I$WRF_LIBRARY/include LDFLAGS=-L$WRF_LIBRARY/lib --prefix=$WRF_LIBRARY
make
make install

wget https://downloads.unidata.ucar.edu/netcdf-cxx/4.3.1/netcdf-cxx4-4.3.1.tar.gz
./configure --enable-shared CPPFLAGS=-I$WRF_LIBRARY/include LDFLAGS=-L$WRF_LIBRARY/lib --prefix=$WRF_LIBRARY
make
make install

# Ubuntu
sudo apt install libnetcdf*-dev
```

### 6. libpng

```shell
wget https://download.sourceforge.net/libpng/libpng-1.6.39.tar.gz
./configure --enable-shared --prefix=$WRF_LIBRARY
make
make install
```

### 7. jasper

```shell
wget https://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz
# wget https://github.com/jasper-software/jasper/releases/download/version-4.0.0/jasper-4.0.0.tar.gz
./configure --enable-shared --prefix=$WRF_LIBRARY
make
make install
```

### 8. mpich 并行计算

```shell
wget https://www.mpich.org/static/downloads/3.0.4/mpich-3.0.4.tar.gz
./configure --prefix=$WRF_LIBRARY
make
make install
```

## WRF

```shell
wget https://github.com/wrf-model/WRF/releases/download/v4.4.1/v4.4.1.tar.gz
./configure arw
./compile em_real
# -> main/ndown.exe
#    main/real.exe
#    main/tc.exe
#    main/wrf.exe
```

## WPS

```shell
wget https://github.com/wrf-model/WPS/archive/refs/tags/v4.4.tar.gz
./configure
./compile
```

## WRDFDA

## WRFDA

3dvar

```shell
./configure wrfda
./compile all_wrfvar
# 生成 44 个可执行文件
ls -l var/build/*exe var/obsproc/src/obsproc.exe
```

4dvar

```shell
# 编译 wrfplus
./configure wrfplus
./compile wrfplus
export WRFPLUS_DIR=/home/ahri/WRFV4/WRFPLUS
# 编译 wrfda 4dvar
./configure 4dvar
./compile all_wrfvar
```

## [GSI](https://dtcenter.org/community-code/gridpoint-statistical-interpolation-gsi)

依赖

```shell
yum install blas-devel lapack-devel
```

```shell
export FFLAGS="-m64 -std=legacy"

# ENKF(ENSEMBLE KALMAN FILTER SYSTEM 集合卡尔曼滤波系统)
wget https://dtcenter.org/sites/default/files/comGSIv3.7_EnKFv1.3.tar.gz
mkdir build
cd build
cmake ..
# for huadi
cmake .. -DZLIB_INCLUDE_DIR=/apps/include -DZLIB_LIBRARY=/apps/lib
make
```

## utils

### ncview

```shell
# CentOS
wget ftp://cirrus.ucsd.edu/pub/ncview/ncview-2.1.7.tar.gz
yum install xorg-x11* libXaw*
./configure --with-nc-config=$WRF_LIBRARY/bin/nc-config --with-udunits2_incdir=$WRF_LIBRARY/include --with-udunits2_libdir=$WRF_LIBRARY/lib --with-png_incdir=$WRF_LIBRARY/include --with-png_libdir=$WRF_LIBRARY/lib --prefix=$WRF_LIBRARY
make
make install
# Ubuntu
sudo apt-get install ncview
```

### nco

```shell
wget https://github.com/nco/nco/archive/refs/tags/5.0.3.tar.gz
./configure --enable-netcdf-4 --enable-udunits2 NETCDF_ROOT=$WRF_LIBRARY UDUNITS2_PATH=$WRF_LIBRARY --prefix=$WRF_LIBRARY
make
make install
```

### cdo

```shell
wget https://code.mpimet.mpg.de/attachments/download/26370/cdo-2.0.0.tar.gz
./configure --with-szlib=$WRF_LIBRARY --with-hdf5=$WRF_LIBRARY --with-netcdf=$WRF_LIBRARY --with-udunits2=$WRF_LIBRARY --prefix=$WRF_LIBRARY
make
make install
```

### ncl

```shell
# 4. ncl(NCAR Command Language) https://www.ncl.ucar.edu/
# https://www.ncl.ucar.edu/Download/list_of_binaries.shtml
# conda
conda install -c conda-forge ncl
# CentOS
wget https://www.earthsystemgrid.org/dataset/ncl.662.dap/file/ncl_ncarg-6.6.2-CentOS7.6_64bit_gnu485.tar.gz
# Ubuntu
sudo apt install ncl-ncarg
```
