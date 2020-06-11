## 自动备份

### 创建 backup.sh 备份脚本如下，可根据备注做适当修改

```
#!/bin/bash
# Name:bakcup.sh
# This is a ShellScript For Auto DB Backup and Delete old Backup

#备份目录
BACKUP_ROOT=/mysql/backup
BACKUP_FILEDIR=$BACKUP_ROOT/files
BACKUP_LOGDIR=$BACKUP_ROOT/logs
#当前日期
DATE=$(date +%Y%m%d)
#账号密码
DB_USER=root
DB_PASS=root
#备份保留天数
BACK_HOLD_DAY=5

######备份######

#查询所有数据库
#-uroot -p123456表示使用root账号执行命令，且root账号的密码为:123456
DATABASES=$(mysql -u$DB_USER -p$DB_PASS -e "show databases" | grep -Ev "Database|sys|information_schema")
#DATABASES=$(mysql -u$DB_USER -p$DB_PASS -e "SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME NOT IN ('sys','mysql','information_schema','performance_schema');" | grep -v "SCHEMA_NAME","ken.io") 
echo $DATABASES
#循环数据库进行备份
for db in $DATABASES
do
echo
echo ----------$BACKUP_FILEDIR/${db}_$DATE.sql.gz BEGIN----------
mysqldump -uroot -p$DB_USER@$DB_PASS --default-character-set=utf8 -q --lock-all-tables --flush-logs -E -R --triggers -B ${db} | gzip > $BACKUP_FILEDIR/mysql_${db}_$DATE.sql.gz
echo ----------$BACKUP_FILEDIR/mysql_${db}_$DATE.sql.gz COMPLETE----------

#传输至备份服务器，如果保留本机则不需要此步骤
#scp $BACKUP_FILEDIR/mysql_${db}_$DATE.sql.gz 22.122.51.158:/data/bakup/159/

echo
done

#保留10日
find $BACKUP_FILEDIR -name "mysql_*.sql.gz" -type f -mtime +$BACK_HOLD_DAY -exec rm -rf {} \;

echo "done"
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
