# [MariaDB](https://mariadb.org/zh/)/MySQL

## 安装

=== "Windows"

    [下载 zip 文件](https://mariadb.org/download/)

    ```shell
    # 管理员权限
    mysql_install_db.exe --service=MariaDB --password=password
    ```

    开启 MariaDB 服务

    ```shell
    sc start MariaDB
    ```

    删除 MariaDB 服务

    ```shell
    sc stop MariaDB
    sc delete MariaDB
    rmdir /s /q /mariadb-version-winx64/data
    ```

=== "linux"

    === "CentOS"

        ```shell
        yum install -y mariadb
        ```

## InnoDB 存储引擎

.frm 表结构文件

.idb 表数据和索引文件
