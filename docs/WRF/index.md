# [WRF](https://www.mmm.ucar.edu/models/wrf)

![wrf 流程](https://www2.mmm.ucar.edu/wrf/users/wrf_users_guide/build/html/_images/wrf_system_flow_chart.png)

- [ARW OnLine Tutorial](https://www2.mmm.ucar.edu/wrf/OnLineTutorial/index.php)
- [Welcome to WRF User’s Guide!](https://www2.mmm.ucar.edu/wrf/users/wrf_users_guide/build/html/index.html)
- [WRFv4 User Guide](https://www2.mmm.ucar.edu/wrf/users/docs/user_guide_v4/v4.4)

WRF 各文件夹结构

```txt
/home/ahri/WRFV4
            │
            ├── WRF     -> WRF 预测
            ├── WPS     -> WRF 预处理
            ├── WRFDA   -> wrfda 同化
            ├── GSI     -> gsi.x 同化
            ├── run     -> 大多数可执行文件的运行文件夹
            └── test_*  -> 用来执行官方案例
```

- [编译安装](build.md)
- [运行流程](run.md)
- [数据下载](data.md)
- [常见错误](error.md)

大气数值模式本质是应用各种数值算法，求解一组偏微分方程组的数值解

## 全球模式和区域模式

- 全球模式只需要初始条件，无需边界条件
- 区域模式需要初始条件和侧边界条件（四条边上的值）

## 资料同化

- WRFDA
- GSI

资料同化方法

- 多项式插值
- 逐步订正法
- 最有插值
- 变分同化（常用）
- 集合卡尔曼滤波（欧洲、海洋使用）

观测资料种类

- 地面资料
- 探空气球资料
- 风廓线资料
- 飞机报资料
- 浮标资料
- 雷达资料
- 卫星资料

## 数据

常见再分析资料

- ERA5(欧洲)
- FNL(美国)
- JRA(日本)
- CRA(中国)

## WRF 后处理

wrfout 文件采用 Arakawa C-grid(荒川 C 网格) ，UV
分别在经纬维度上比正常多一维。[see also](https://amps-backup.ucar.edu/information/configuration/wrf_grid_structure.html)

---
背景场：background，是利用物理公式计算后的一个大气状态结果<br>
观测场：observation，是利用探测器和观测站测得的大气状态结果<br>
分析场：analysis，是综合考虑了物理公式和观测结果后得出的最接近真实大气的状态结果<br>

预报场：<br>
初始场：模式初始时刻的状态<br>

fnl file: 再分析数据，是分析场，驱动 WRF 是模拟<br>
gfs file: 预报场，驱动 WRF 是预报<br>
gdas file:<br>
bufr file: 观测场<br>

## prepbufr

- obs 观测值
- qcf 质控码

|      |                      |            |
| :--- | :------------------- | :--------- |
| POB  | PRESSURE OBSERVATION | 压强观测值 |

## WRF 变量

### GSI 变量

| short name | long name               | 名称             |
| :--------- | :---------------------- | :--------------- |
| ps         | surface pressure        | 表面压力         |
| t          | temperature             | 温度             |
| q          | moisture                | 湿度             |
| pw         | total column water      | 总降水           |
| u          | zonal wind              | 纬向风           |
| v          | meridional wind         | 经向风           |
| spd        | wind speed              | 风速             |
| dw         | doppler lidar winds     | 多普勒激光雷达风 |
| sst        | sea-surface temperature | 海洋表面温度     |
