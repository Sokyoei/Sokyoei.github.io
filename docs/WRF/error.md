# WPS/WRF/GSI ERROR

## 1. v_cfl 积分错误

### 问题描述

rsl.out.0000 出现下面日志

```log
d03 2022-11-06_06:04:40         1444  points exceeded v_cfl = 2 in domain d03 at time 2022-11-06_06:04:40 hours
d03 2022-11-06_06:04:40 Max   W:      6      1     33 W:   -3.07  w-cfl:    3.89  dETA:    0.01
```

### 解决办法

修改嵌套区域，让 d02 和 d03 不重合

---

## 2. GSI 同化失败

### 问题描述

`ifort` 可能打印以下堆栈问题

```log
forrtl: severe (174): SIGSEGV, segmentation fault occurred
Image              PC                Routine            Line        Source
gsi.x              0000000001961669  Unknown               Unknown  Unknown
libpthread-2.28.s  0000151EFCD88C20  Unknown               Unknown  Unknown
gsi.x              000000000131381F  frfhvo_                    63  smoothzrf.f90
gsi.x              0000000001086A52  bkgcov_                    67  bkgcov.f90
libiomp5.so        0000151EF5934A43  __kmp_invoke_micr     Unknown  Unknown
libiomp5.so        0000151EF58F7CDA  Unknown               Unknown  Unknown
libiomp5.so        0000151EF58F723B  Unknown               Unknown  Unknown
libiomp5.so        0000151EF5934EB1  Unknown               Unknown  Unknown
libpthread-2.28.s  0000151EFCD7E17A  Unknown               Unknown  Unknown
libc-2.28.so       0000151EF462CDC3  clone                 Unknown  Unknown
```

### 解决办法

增加 `OpenMP` 的堆栈大小（`ifort` 默认 4M）

```shell
# 根据模拟区域大小适当设置 (2^n)M
export OMP_STACKSIZE=16M
```

---

## 3. MPI 问题

### 问题描述

可执行文件调用 `Intel MPI` 时出现下面错误

```log
Abort(1094031) on node 0 (rank 0 in comm 0): Fatal error in PMPI_Init: Other MPI error, error stack:
MPIR_Init_thread(607)......:
MPID_Init(793).............:
MPIDI_NM_mpi_init_hook(667): OFI addrinfo() failed (ofi_init.h:667:MPIDI_NM_mpi_init_hook:No data available)
```

### 解决方法

添加 [OFI][OFI] 环境变量以链接到 `libfabric`, 进而链接到 `Intel MPI`

```shell
export FI_PROVIDER=sockets
# export FI_PROVIDER=tcp  # 应该也可以
```

[OFI]: https://www.intel.com/content/www/us/en/docs/mpi-library/developer-guide-linux/2021-6/ofi-providers-support.html

---

## 4. real.exe ERROR

### 问题描述

国家数据集 CMA-GFS real.exe rsl.error.0000 出现下面的错误

```log
Not enough soil temperature data for Noah LSM scheme
```

### 解决方法

sf_surface_physics(默认使用的 CONUS 套装 = 2) 更改为 1<br>
之后又可以正常运行

---

## 5. metgrid.exe ERROR: Error in ext pkg write field

### 问题描述

2024 年美国 GFS 数据集运行 metgrid.exe 时失败，2023 年的数据可以正常运行，log.metgrib 出现下面错误

```log
ERROR: Error in ext_pkg_write_field
```

### 解决方法

gfs 数据集有问题，更换其他天数的数据集

## 6. CMA-GFS 数据集 ungrib.exe 运行慢

### 问题描述

运行24小时的情况下：<br>
国家数据集精度是 0.125°，用时 20~30 分钟<br>
美国数据集精度是 0.25°，用时 2~3 分钟<br>
正常应该慢4倍左右，实际慢10倍左右<br>

### 解决方法

暂无，使用多台机器并行
