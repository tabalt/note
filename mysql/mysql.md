# MySql 
@author `tabalt`

### 一、Mysql install

----------

    yum install mysql


### 二、Mysql command

----------

安装完的MySQL，MySQL权限管理上只一有个root用户，密码为空，而且只能在本机登录

    #为root加上密码
    mysqladmin -uroot password
    xxx123 #input password 
    #更改root的密码
    mysqladmin -uroot -pxxx123 password 1234

    #开放管理MySQL中所有数据库的权限
    grant all on *.* to dbuser@'127.0.0.1' identified by "dbapasswd";
    #开放管理MySQL中具体数据库的权限
    grant all on dbname to dbuser@'127.0.0.1' identified by "dbapasswd";


    # http://database.51cto.com/art/201010/229498.htm 
    # http://database.51cto.com/art/201010/229503.htm
