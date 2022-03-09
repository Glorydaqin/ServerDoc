#! /bin/bash

# 批量导出指定数据库到新的数据库
# The below script can be used to export data  from old database and move to new database.

USERNAME=""
PASSWORD=""
OLD_HOST=""
OLD_PORT=""
NEW_HOST=""
NEW_PORT=""
DUMP_DIR=""

# Commands to create new user in database
# CREATE USER 'username'@'%' IDENTIFIED BY 'password'; -- Create new user
# GRANT ALL PRIVILEGES ON *.* TO 'username'@'%'; -- To Grant all permissions
# SHOW GRANTS FOR 'username'@'localhost'; -- To list all privilates


DBS=("database1" "database2") # list of databases to export and import

for DB in ${DBS[@]}; do
    # In case of mysql 8 add --column-statistics=0 to the dump command
    DUMP_COMMAND="mysqldump --host=$OLD_HOST --port=$OLD_PORT -u $USERNAME --password=$PASSWORD --single-transaction --add-drop-database --databases $DB > $DUMP_DIR/$DB.sql"
    RESTORE_COMMAND="mysql --host=$NEW_HOST --port=$NEW_PORT -u $USERNAME --password=$PASSWORD <  $DUMP_DIR/$DB.sql"
    echo $DUMP_COMMAND
    eval $DUMP_COMMAND    
    echo "-----Dump completed for $DB-----"

    echo $RESTORE_COMMAND
    eval $RESTORE_COMMAND
    echo "-----Restore completed for $DB-----"
    REMOVE_DUMP="rm -rf $DUMP_DIR/$DB.sql"
    eval $REMOVE_DUMP;
    echo "-----Removed dump for $DB-----"
done
