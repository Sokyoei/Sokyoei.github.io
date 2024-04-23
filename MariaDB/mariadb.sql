------------------------------------------------------------------------------------------------------------------------
-- MariaDB/MySQL
------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
-- @brief 创建账户
-- @param host 指定用户在那个主机上可以登录，本地为 localhost，从任意主机上登录可以为通配符 %
-- @example
-- create user 'ahri'@'localhost' identified by 'ahri';
-- create user 'sokyoei'@'192.168.1.1' identified by 'sokyoei';
-- create user 'nono'@'%' identified by 'nono';
create user 'username'@'host' identified by 'password';

-- @brief 授予用户权限
-- @param privileges 用户权限，select, insert, update... 授予所有权限为 all
-- with grant option 允许被授权的用户把得到的权限继续授权给其他用户
-- @example
-- grant all on *.* to 'ahri'@'localhost' with grant option;
grant privileges on database_name.table_name to 'username'@'host' with grant option;

-- @brief 更改密码
set password for 'username'@'host' = password('new_password');
-- @brief 当前用户更改密码
set password = password('new_password');

-- @brief 撤销用户权限
-- @param privileges @see 授予用户权限
revoke privileges on database_name.table_name from 'username'@'host';

-- @brief 删除用户
drop user 'username'@'host';

-- @brief 查看用户权限
show grants for 'username'@'host';

------------------------------------------------------------------------------------------------------------------------
-- @brief 显示所有数据库
show databases;

-- @brief 进入数据库
use database_name;

-- @brief 显示当前数据库中所有表
show tables;

-- @brief 创建表
create table `table_name` (
    `id` bigint(20) not null auto_increment comment '身份证',
) engine=innodb charset=utf8 comment='table_comment';

-- @brief 删除表
drop table if exists table_name;

-- @brief 查询表
select * from table_name;

-- @brief 执行 sql_name.sql 文件
source sql_name.sql;
source < sql_path;
