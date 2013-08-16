#!/bin/bash
# read mysql fields and formate 
# pengming 
DB_USER='root'
DB_NAME='security'
DB_PASS='mysql'
# login mysql , show tables write tables infomations to file /tmp/tables.tmp
mysql -u ${DB_USER} -p${DB_PASS} -D ${DB_NAME} -e 'show tables' > /tmp/tables.tmp
i=-1
while read table_list
do
    if [ $i -ne -1 ];
    then
        tables[$i]=$table_list
    fi
    let i++
done < /tmp/tables.tmp
for table in ${tables[@]}
do
    echo ${table}
done
