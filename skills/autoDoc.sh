#!/bin/bash
# read mysql fields and formate 
# pengming 
DB_USER='root'
DB_NAME='security'
DB_PASS='mysql'
# 登录mysql选择库显示所有表名保存到文件
mysql -u ${DB_USER} -p${DB_PASS} -D ${DB_NAME} -e 'show tables' > /tmp/tables.tmp

# 读取文件每一行到数组
i=-1
while read table_list
do
    if [ $i -ne -1 ];
    then
        tables[$i]=$table_list
    fi
    let i++
done < /tmp/tables.tmp

# 传入表名获取表结构分割组合
function exchange () {
    echo '<table>' >> /tmp/doc.tmp
#TODO 将每个表的id没有备注的加上备注
    mysql -u ${DB_USER} -p${DB_PASS} -D ${DB_NAME} -e "show full columns from ${1}" | awk 'NR>1 {{FS="\t"} {printf "%20s %20s %20s\n" , $1, $2, $9}}' | while read filed type comment
    do 
        echo "<tr><td>${filed}</td><td>${type}<td><td>${comment}</td><tr>" >> /tmp/doc.tmp
    done
    echo '</table>' >> /tmp/doc.tmp
    echo '' >> /tmp/doc.tmp
}

# 遍历表名数组
for table in ${tables[@]}
do
    exchange $table
done

