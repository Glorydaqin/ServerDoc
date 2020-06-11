## 自动备份

### 创建 backup.sh 备份脚本如下，可根据备注做适当修改

```
#!/bin/bash
# Name:bakcup.sh
# This is a ShellScript For Auto DB Backup and Delete old Backup

# 参数说明：
# backupdir 保存路径的绝对地址
# 代码中 time=` date +%Y%m%d`也可以写为time=”$(date +”%Y%m%d”)” 找到当前日期时间格式
# 其中`符号是TAB键上面的符号，不是ENTER左边的’符号，还有date后要有一个空格。
#mysql_bin_dir：mysql的bin路径；
#dataname：数据库名；
#user：数据库用户名；
#password：用户密码；
#name：自定义备份文件前缀标识
# name：自定义备份文件前缀标识。
# -type f    表示查找普通类型的文件，f表示普通文件。
# -mtime +30   按照文件的更改时间来查找文件，+30表示文件更改时间距现在30天以前；如果是 -mmin +7 表示文件更改时间距现在7分钟以前。
# -exec rm -rf {} \;   表示执行一段shell命令，exec选项后面跟随着所要执行的命令或脚本，然后是一对儿{}，一个空格和一个\，最后是一个分号。

#数据库备份的位置
backupdir=/home/mysqlbak
time=` date +%Y%m%d%H%M%S`
#需要备份的数据库的连接的用户名和密码和数据库
#mysql_bin_dir/mysqldump -uuser -ppassword dataname | gzip > $backupdir/name$time.sql.gz
/usr/bin/mysqldump -u root -pBlqy_scsio_1 scsio | gzip > $backupdir/mysql_$time.sql.gz
#传输至备份服务器，如果保留本机则不需要此步骤
#scp $backupdir/mysql_$time.sql.gz 22.122.51.158:/data/bakup/159/
#find $backupdir -name "name*.sql.gz" -type f -mtime +30 -exec rm -rf {} \;
#保留10日
find $backupdir -name "mysql_*.sql.gz" -type f -mtime +10 -exec rm -rf {} \;

```

### 添加可执行权限
``` 
chmod +x backup.sh
```

### 配置定时任务

``` 
crontab -e

#每日执行
0 2 * * * /home/mysqlbak/backup.sh
```
