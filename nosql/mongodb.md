# MongoDB

@author `tabalt`

### 一、安装

----------

#### 1、Ubuntu下快速安装MongoDB
    

    sudo apt-get install mongodb
    # 安装完成后会自动运行mongod，可以输入命令 “pgrep mongo -l” 查看mongod进程是否已经启动；
    pgrep mongo -l
    1048 mongod
    # 也可以在终端中输入“mongo” 并回车，看是否连上默认数据库;
    mongo

        
#### 2、CentOS下安装MongoDB
    
    # http://www.mongodb.org/downloads
    wget http://fastdl.mongodb.org/linux/mongodb-linux-i686-2.4.5.tgz
    tar -zxvf mongodb-linux-i686-2.4.5.tgz
    cd mongodb-linux-i686-2.4.5

    # 复制执行文件
    mkdir -p /usr/local/mongodb/bin
    cp bin/* /usr/local/mongodb/bin

    # 创建数据存放目录
    mkdir -p /data0/mongodb/data
    mkdir -p /data0/mongodb/log

    # 添加CentOS开机启动项 
    vim /etc/init.d/rc.local
        /usr/local/mongodb/bin/mongod --dbpath=/data0/mongodb/data --logpath=/data0/mongodb/log/log.log -fork

    # 启动mongodb
    /usr/local/mongodb/bin/mongod --dbpath=/data0/mongodb/data --logpath=/data0/mongodb/log/log.log -fork

    #进入mongodb的shell模式 
    /usr/local/mongodb/bin/mongo


### 二、基本配置
    
----------

    



### 三、SHELL常用操作

----------
 

    # 查看数据库列表 
    show dbs
    # 切换/创建数据库(当创建一个集合(table)的时候会自动创建当前数据库)
    use admin;
    # 增加用户
    db.addUser("tabalt ","123456",true)
    # 更改密码（为已经存在的用户更改密码） 
    db.addUser("tabalt "," tabalt "); 
    # 显示当前db状态 
    db.stats();
    # 当前db版本 
    db.version();
    # 删除当前使用数据库 
    db.dropDatabase();
    # 查看当前db的链接机器地址 
    db.getMongo();
    # 简单插入数据 
    db.user.insert({"fname":"tabalt", "company":"tabalt"})
    # 循环插入数据 
    for (var i = 1; i <= 10; i++) {
        db.user.save({ "fname" : "tabalt"+i, "company" : "tabalt"+i });
    }
    # 查询数据 
    db.user.find()



### 四、高级指南

----------

    


### 五、应用经验

----------