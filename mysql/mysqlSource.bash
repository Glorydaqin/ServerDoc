#!/bin/bash  

# 批量导入目录下的sql文件，导入的路径，绝对路径
p="/root/data"
dbUser='root'  
dbPassword='daqing66'  

cd $p;  
for f in `ls $p/*.sql`  
do  
echo $f;  
mysql -u $dbUser -p$dbPassword -e "source $f";  
mv $f $f.done;  
done  
echo 'OK!'
