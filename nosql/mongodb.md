# MongoDB

@author `tabalt`

### 一、安装

----------

#### 1、Ubuntu下快速安装MongoDB

    1) 在终端中输入命令：
        sudo apt-get install mongodb
    2) 安装完成后会自动运行mongod，可以输入命令 “pgrep mongo -l” 查看mongod进程是否已经启动；

        ubuntu@ubuntu:~$ pgrep mongo -l
        1048 mongod

    3) 也可以在终端中输入“mongo” 并回车，看是否连上默认数据库;

        ubuntu@ubuntu:~$ mongo
        MongoDB shell version: 2.0.4
        connecting to: test
        > 


### 基本配置
    
----------


### 常用操作

----------

#### SHELL

    show dbs;
    db.blog.user.insert({"user":"yanping9",name:"TanYanping","age":23,"passwd":"123456"})
    db.blog.user.find()



### 高级指南

----------


### 应用经验

----------