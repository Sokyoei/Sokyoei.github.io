# WRF 运行

```shell
mkdir /home/ahri/WRFV4/run
cd /home/ahri/WRFV4/run
```

!!! warning "对于小型计算机可能需要进行如下设置"

    ```shell
    ulimit -s unlimited
    export OMP_STACKSIZE=16M  # 2^n
    ```

## WPS

设置链接

```shell
ln -sf /home/ahri/WRFV4/WPS/geogrid.exe
ln -sf /home/ahri/WRFV4/WPS/ungrib.exe
ln -sf /home/ahri/WRFV4/WPS/metgrid.exe
ln -sf /home/ahri/WRFV4/WPS/link_grib.csh
```

### geogrid.exe

> 定义模型域并将静态地理数据插值到网格

[下载静态地图数据](https://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog.html)

```shell
wget https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_high_res_mandatory.tar.gz
```

配置文件 [namelist.wps](https://github.com/wrf-model/WPS/blob/master/namelist.wps)
([doc](https://www2.mmm.ucar.edu/wrf/users/namelist_best_prac_wps.html))

查看静态地图文件来确定区域是否正确

```shell
ncl ./utils/plotgrids_new.ncl
```

geogrid.exe

```shell
# in: namelist.wps
./geogrid.exe
# out: geo_em.d0*.nc
```

### ungrib.exe

> 从 GRIB 格式的文件中提取气象字段（单核运行）

设置 Vtable

```shell
ln -sf ./ungrib/Variable_Tables/Vtable.GFS ./Vtable
```

链接数据

```shell
# in: gfs/fnl file
./link_grib.csh datasets_path/*
# out: GRIBFILE.AAA, GRIBFILE.AAB ...
```

ungrib.exe

```shell
# in: GRIBFILE.AAA, GRIBFILE.AAB ...
./ungrib.exe
# out: FILE:YYYY-MM-DD_HH
```

查看内容（可选）

```shell
./util/rd_intermediate.exe FILE:YYYY-MM-DD_HH
```

### metgrid.exe

> 将 ungrib.exe 提取的气象数据水平插值到 geogrid.exe 定义的模型网格中

```shell
# in: geo_em.d0*.nc, FILE:YYYY-MM-DD_HH
./metgrid.exe
# out: met_em.d0*.YYYY-MM-DD_HH:MM:SS.nc
```

[//]: # (Note: The following floating-point exceptions are signalling: IEEE_OVERFLOW_FLAG IEEE_UNDERFLOW_FLAG IEEE_DENORMAL)

## WRF(&GSI)

```shell
ln -sf /home/ahri/WRFV4/WRF/run/real.exe
ln -sf /home/ahri/WRFV4/WRF/run/wrf.exe
```

### real.exe

> 气象场的垂直插值、生成初始条件和边界条件、一致性检查

配置文件 [namelist.input](https://github.com/wrf-model/WRF/blob/master/run/README.namelist)<br>
ra_lw_physics Longwave Radiation 长波辐射<br>
ra_sw-physics Shortwave Radiation 短波辐射<br>
sf_surface_physics land-surface option 路面过程<br>

real.exe

```shell
# in: met_em.d0*.YYYY-MM-DD_HH:MM:SS.nc
mpirun -np 4 ./real.exe
# out: wrfbdy_d0*
#      wrfinput_d0*
#      ...
```

### wrfda/gsi(可选)

```shell
mkdir /home/ahri/WRFV4/run/da
```

> 观测数据同化

#### 3dvar

官方示例

```shell
export WRFDA_DIR=/home/ahri/WRFV4/WRFDA
export DATA_DIR=/home/ahri/WRFV4/test_wrfda/data

ln -sf $WRFDA_DIR/run/LANDUSE.TBL
ln -sf $WRFDA_DIR/var/build/da_wrfvar.exe

# 链接背景误差文件
ln -sf $DATA_DIR/be/be.dat

# 适用于 NCEP 的 背景误差文件
ln -sf /home/ahri/WRFV4/WRFDA/var/run/be.dat.cv3 be.dat

# 链接 ascii 观测文件
ln -sf $DATA_DIR/ob/2008020512/ob.ascii
# 或者链接 prepbufr 常规观测文件
ln -fs $DATA_DIR/ob/2008020512/gdas1.t12z.prepbufr.nr ob.bufr
# 链接第一次猜测文件
ln -sf $DATA_DIR/rc/2008020512/wrfinput_d01 ./fg
# 复制 namelist.input
cp $DATA_DIR/namelist.input.3dvar namelist.inpb ut

ulimit -s unlimited
mpirun -np 16 ./da_wrfvar.exe
```

##### 生成 be.dat

复制 gen_be_wrapper.ksh

```shell
cp $WRFDA_DIR/var/scripts/gen_be/gen_be_wrapper.ksh .
```

参考：

- https://zhuanlan.zhihu.com/p/565561915

#### 4dvar

官方示例(运行失败)

```shell
export WRFDA_DIR=/home/ahri/WRFV4/WRFDA
export DATA_DIR=/home/ahri/WRFV4/test_wrfda/data

cd /home/ahri/WRFV4/test_wrfda

ln -fs $DATA_DIR/ob/2008020512/ob01.ascii ob01.ascii
ln -fs $DATA_DIR/ob/2008020513/ob02.ascii ob02.ascii
ln -fs $DATA_DIR/ob/2008020514/ob03.ascii ob03.ascii
ln -fs $DATA_DIR/ob/2008020515/ob04.ascii ob04.ascii
ln -fs $DATA_DIR/ob/2008020516/ob05.ascii ob05.ascii
ln -fs $DATA_DIR/ob/2008020517/ob06.ascii ob06.ascii
ln -fs $DATA_DIR/ob/2008020518/ob07.ascii ob07.ascii

ln -fs $DATA_DIR/ob/2008020512/gdas1.t12z.prepbufr.nr ob01.bufr
ln -fs $DATA_DIR/ob/2008020518/gdas1.t18z.prepbufr.nr ob02.bufr

ln -fs $DATA_DIR/rc/2008020512/wrfinput_d01
ln -fs $DATA_DIR/rc/2008020512/wrfbdy_d01
ln -fs wrfinput_d01 fg

ln -fs $DATA_DIR/be/be.dat
ln -fs $WRFDA_DIR/run/LANDUSE.TBL
ln -fs $WRFDA_DIR/run/GENPARM.TBL
ln -fs $WRFDA_DIR/run/SOILPARM.TBL
ln -fs $WRFDA_DIR/run/VEGPARM.TBL
ln -fs $WRFDA_DIR/run/RRTM_DATA_DBL RRTM_DATA
ln -sf $WRFDA_DIR/run/CAMtr_volume_mixing_ratio
ln -sf $WRFDA_DIR/var/build/da_wrfvar.exe

cp $DATA_DIR/namelist.input.4dvar namelist.input
```

生成 be.dat 背景误差文件

```shell
cp WRFDA/var/scripts/gen_be/gen_be_wrapper.ksh .
```

#### gsi.x

> 观测数据同化

[DTC || Community GSI Users Page](https://dtcenter.ucar.edu/com-GSI/users/docs/)

[doc](https://dtcenter.ucar.edu/com-GSI/users/docs/users_guide/html_v3.7/)

[CRTM](https://dtcenter.org/dfiles/code/gsi/CRTM_v2.3.0.tar.gz) (Community Radiative Transfer Model 社区辐射转移模型)

[fix files](https://dtcenter.org/sites/default/files/comGSIv3.7_EnKFv1.3_fix_global.tar.gz)

调用 ksh 脚本运行 gsi.x

```shell
cd ~/GSI
ksh /ush/comgsi_run_regional.ksh
```

```shell title="comgsi_run_regional.ksh"
--8<-- "docs/WRF/comgsi_run_regional.ksh"
```

### wrf.exe

> 模式运行，生成 wrfout 文件

```shell
# in: wrfinput_d0* wrfbody_d01...
mpirun -np 4 ./wrf.exe
# out: wrfout_d0*_YYYY-MM-DD_HH:MM::SS
#      wrfrst_d0*_YYYY-MM-DD_HH:MM::SS
#      ...
```
