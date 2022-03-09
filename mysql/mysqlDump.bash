#!/bin/bash
# 批量导出数据库到本地目录，排除指定数据库

USER="zend"
PASSWORD=""
ExcludeDatabases="Database|information_schema|performance_schema|mysql"
databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | egrep -v $ExcludeDatabases`

for db in $databases; do
    echo "Dumping database: $db"
    mysqldump -u $USER -p$PASSWORD --databases $db > `date +%Y%m%d`.$db.sql
done
