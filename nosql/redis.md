# Redis

@author `tabalt`

### 一、安装

----------

    

### 二、安装PHP redis扩展

----------

    #安装php的redis扩展 
    sudo pecl install redis
    sudo vim /etc/php.ini
        extension=redis.so
    sudo apachectl restart


### 二、PHP操作redis

基本操作

    $redis = new Redis();
    #connect, open 链接redis服务
    $redis->connect('127.0.0.1', 6379); 
    $redis->auth('sinasec');
    $redis->hLen('godns:hosts');
    $redis->hKeys('godns:hosts');
    $redis->hVals('godns:hosts');
    $redis->hGetAll('godns:hosts');



