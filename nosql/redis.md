# Redis

@author `tabalt`

### 一、redis安装

----------

* 源码安装


        #http://redis.io/download
        wget http://redis.googlecode.com/files/redis-2.6.14.tar.gz
        tar -zxvf redis-2.6.14.tar.gz
        cd redis-2.6.14
        make
        cd src
        make install

* 移动文件 便于管理

        mkdir -p /usr/local/redis/bin
        mkdir -p /usr/local/redis/etc
        mv ../redis.conf /usr/local/redis/etc/redis.conf
        mv mkreleasehdr.sh redis-benchmark redis-check-aof redis-check-dump redis-cli redis-server /usr/local/redis/bin

* 启动redis服务

        /usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf

* 连接redis服务器

        /usr/local/redis/bin/redis-cli



### 二、redis配置详解

----------


* Redis默认不是以守护进程的方式运行，可以通过该配置项修改，使用yes启用守护进程

        daemonize no


* 当Redis以守护进程方式运行时，Redis默认会把pid写入/var/run/redis.pid文件，可以通过pidfile指定

        pidfile /var/run/redis.pid


* 指定Redis监听端口，默认端口为6379，作者在自己的一篇博文中解释了为什么选用6379作为默认端口，因为6379在手机按键上MERZ对应的号码，而MERZ取自意大利歌女Alessia Merz的名字

        port 6379


* 绑定的主机地址

        bind 127.0.0.1


* 当客户端闲置多长时间后关闭连接，如果指定为0，表示关闭该功能
    
        timeout 300

* 指定日志记录级别，Redis总共支持四个级别：debug、verbose、notice、warning，默认为verbose

        loglevel verbose

* 日志记录方式，默认为标准输出，如果配置Redis为守护进程方式运行，而这里又配置为日志记录方式为标准输出，则日志将会发送给/dev/null

        logfile stdout

* 设置数据库的数量，默认数据库为0，可以使用SELECT <dbid>命令在连接上指定数据库id

        databases 16

* 指定在多长时间内，有多少次更新操作，就将数据同步到数据文件，可以多个条件配合

        save <seconds> <changes>

    Redis默认配置文件中提供了三个条件：

        save 900 1
        save 300 10
        save 60 10000

    分别表示900秒（15分钟）内有1个更改，300秒（5分钟）内有10个更改以及60秒内有10000个更改。

 

* 指定存储至本地数据库时是否压缩数据，默认为yes，Redis采用LZF压缩，如果为了节省CPU时间，可以关闭该选项，但会导致数据库文件变的巨大

        rdbcompression yes

* 指定本地数据库文件名，默认值为dump.rdb

        dbfilename dump.rdb

* 指定本地数据库存放目录

        dir ./

* 设置当本机为slav服务时，设置master服务的IP地址及端口，在Redis启动时，它会自动从master进行数据同步

        slaveof <masterip> <masterport>

* 当master服务设置了密码保护时，slav服务连接master的密码

        masterauth <master-password>

* 设置Redis连接密码，如果配置了连接密码，客户端在连接Redis时需要通过AUTH <password>命令提供密码，默认关闭

        requirepass foobared

* 设置同一时间最大客户端连接数，默认无限制，Redis可以同时打开的客户端连接数为Redis进程可以打开的最大文件描述符数，如果设置 maxclients 0，表示不作限制。当客户端连接数到达限制时，Redis会关闭新的连接并向客户端返回max number of clients reached错误信息

        maxclients 128

* 指定Redis最大内存限制，Redis在启动时会把数据加载到内存中，达到最大内存后，Redis会先尝试清除已到期或即将到期的Key，当此方法处理 后，仍然到达最大内存设置，将无法再进行写入操作，但仍然可以进行读取操作。Redis新的vm机制，会把Key存放内存，Value会存放在swap区

        maxmemory <bytes>

* 指定是否在每次更新操作后进行日志记录，Redis在默认情况下是异步的把数据写入磁盘，如果不开启，可能会在断电时导致一段时间内的数据丢失。因为 redis本身同步数据文件是按上面save条件来同步的，所以有的数据会在一段时间内只存在于内存中。默认为no

        appendonly no

* 指定更新日志文件名，默认为appendonly.aof

        appendfilename appendonly.aof

* 指定更新日志条件，共有3个可选值： 

        no：表示等操作系统进行数据缓存同步到磁盘（快） 
        always：表示每次更新操作后手动调用fsync()将数据写到磁盘（慢，安全） 
        everysec：表示每秒同步一次（折衷，默认值）
        appendfsync everysec

 

* 指定是否启用虚拟内存机制，默认值为no，简单的介绍一下，VM机制将数据分页存放，由Redis将访问量较少的页即冷数据swap到磁盘上，访问多的页面由磁盘自动换出到内存中（在后面的文章我会仔细分析Redis的VM机制）

        vm-enabled no

* 虚拟内存文件路径，默认值为/tmp/redis.swap，不可多个Redis实例共享

        vm-swap-file /tmp/redis.swap

* 将所有大于vm-max-memory的数据存入虚拟内存,无论vm-max-memory设置多小,所有索引数据都是内存存储的(Redis的索引数据 就是keys),也就是说,当vm-max-memory设置为0的时候,其实是所有value都存在于磁盘。默认值为0

        vm-max-memory 0

* Redis swap文件分成了很多的page，一个对象可以保存在多个page上面，但一个page上不能被多个对象共享，vm-page-size是要根据存储的 数据大小来设定的，作者建议如果存储很多小对象，page大小最好设置为32或者64bytes；如果存储很大大对象，则可以使用更大的page，如果不 确定，就使用默认值

        vm-page-size 32

* 设置swap文件中的page数量，由于页表（一种表示页面空闲或使用的bitmap）是在放在内存中的，，在磁盘上每8个pages将消耗1byte的内存。

        vm-pages 134217728

* 设置访问swap文件的线程数,最好不要超过机器的核数,如果设置为0,那么所有对swap文件的操作都是串行的，可能会造成比较长时间的延迟。默认值为4

        vm-max-threads 4

* 设置在向客户端应答时，是否把较小的包合并为一个包发送，默认为开启

        glueoutputbuf yes

* 指定在超过一定的数量或者最大的元素超过某一临界值时，采用一种特殊的哈希算法

        hash-max-zipmap-entries 64
        hash-max-zipmap-value 512

* 指定是否激活重置哈希，默认为开启（后面在介绍Redis的哈希算法时具体介绍）

        activerehashing yes

* 指定包含其它的配置文件，可以在同一主机上多个Redis实例之间使用同一份配置文件，而同时各个实例又拥有自己的特定配置文件

        include /path/to/local.conf
    

### 三、redis命令大全

----------

* 连接操作相关的命令

    * quit：关闭连接（connection）
    * auth：简单密码认证

* 持久化

    * save：将数据同步保存到磁盘
    * bgsave：将数据异步保存到磁盘
    * lastsave：返回上次成功将数据保存到磁盘的Unix时戳
    * shundown：将数据同步保存到磁盘，然后关闭服务

* 远程服务控制

    * info：提供服务器的信息和统计
    * monitor：实时转储收到的请求
    * slaveof：改变复制策略设置
    * config：在运行时配置Redis服务器

* 对value操作的命令

    * exists(key)：确认一个key是否存在
    * del(key)：删除一个key
    * type(key)：返回值的类型
    * keys(pattern)：返回满足给定pattern的所有key
    * randomkey：随机返回key空间的一个
    * keyrename(oldname, newname)：重命名key
    * dbsize：返回当前数据库中key的数目
    * expire：设定一个key的活动时间（s）
    * ttl：获得一个key的活动时间
    * select(index)：按索引查询
    * move(key, dbindex)：移动当前数据库中的key到dbindex数据库
    * flushdb：删除当前选择数据库中的所有key
    * flushall：删除所有数据库中的所有key

* 对String操作的命令

    * set(key, value)：给数据库中名称为key的string赋予值value
    * get(key)：返回数据库中名称为key的string的value
    * getset(key, value)：给名称为key的string赋予上一次的value
    * mget(key1, key2,…, key N)：返回库中多个string的value
    * setnx(key, value)：添加string，名称为key，值为value
    * setex(key, time, value)：向库中添加string，设定过期时间time
    * mset(key N, value N)：批量设置多个string的值
    * msetnx(key N, value N)：如果所有名称为key i的string都不存在
    * incr(key)：名称为key的string增1操作
    * incrby(key, integer)：名称为key的string增加integer
    * decr(key)：名称为key的string减1操作
    * decrby(key, integer)：名称为key的string减少integer
    * append(key, value)：名称为key的string的值附加value
    * substr(key, start, end)：返回名称为key的string的value的子串

* 对List操作的命令

    * rpush(key, value)：在名称为key的list尾添加一个值为value的元素
    * lpush(key, value)：在名称为key的list头添加一个值为value的 元素
    * llen(key)：返回名称为key的list的长度
    * lrange(key, start, end)：返回名称为key的list中start至end之间的元素
    * ltrim(key, start, end)：截取名称为key的list
    * lindex(key, index)：返回名称为key的list中index位置的元素
    * lset(key, index, value)：给名称为key的list中index位置的元素赋值
    * lrem(key, count, value)：删除count个key的list中值为value的元素
    * lpop(key)：返回并删除名称为key的list中的首元素
    * rpop(key)：返回并删除名称为key的list中的尾元素
    * blpop(key1, key2,… key N, timeout)：lpop命令的block版本。
    * brpop(key1, key2,… key N, timeout)：rpop的block版本。
    * rpoplpush(srckey, dstkey)：返回并删除名称为srckey的list的尾元素，并将该元素添加到名称为dstkey的list的头部

* 对Set操作的命令

    * sadd(key, member)：向名称为key的set中添加元素member
    * srem(key, member) ：删除名称为key的set中的元素member
    * spop(key) ：随机返回并删除名称为key的set中一个元素
    * smove(srckey, dstkey, member) ：移到集合元素
    * scard(key) ：返回名称为key的set的基数
    * sismember(key, member) ：member是否是名称为key的set的元素
    * sinter(key1, key2,…key N) ：求交集
    * sinterstore(dstkey, (keys)) ：求交集并将交集保存到dstkey的集合
    * sunion(key1, (keys)) ：求并集
    * sunionstore(dstkey, (keys)) ：求并集并将并集保存到dstkey的集合
    * sdiff(key1, (keys)) ：求差集
    * sdiffstore(dstkey, (keys)) ：求差集并将差集保存到dstkey的集合
    * smembers(key) ：返回名称为key的set的所有元素
    * srandmember(key) ：随机返回名称为key的set的一个元素

* 对Hash操作的命令

    * hset(key, field, value)：向名称为key的hash中添加元素field
    * hget(key, field)：返回名称为key的hash中field对应的value
    * hmget(key, (fields))：返回名称为key的hash中field i对应的value
    * hmset(key, (fields))：向名称为key的hash中添加元素field 
    * hincrby(key, field, integer)：将名称为key的hash中field的value增加integer
    * hexists(key, field)：名称为key的hash中是否存在键为field的域
    * hdel(key, field)：删除名称为key的hash中键为field的域
    * hlen(key)：返回名称为key的hash中元素个数
    * hkeys(key)：返回名称为key的hash中所有键
    * hvals(key)：返回名称为key的hash中所有键对应的value
    * hgetall(key)：返回名称为key的hash中所有的键（field）及其对应的value
    

### 四、PHP操作redis

----------

* 安装php的redis扩展 

        sudo pecl install redis
        sudo vim /etc/php.ini
            extension=redis.so
        sudo apachectl restart


* 基本操作

        $redis = new Redis();
        #connect, open 链接redis服务
        $redis->connect('127.0.0.1', 6379); 
        $redis->auth('xxxxxxxx');
        $redis->hLen('xxx:xxx');
        $redis->hKeys('xxx:xxx');
        $redis->hVals('xxx:xxx');
        $redis->hGetAll('xxx:xxx');


### 五、go语言操作redis

----------

* go语言中比较不错的redis驱动：https://github.com/hoisie/redis

        go get github.com/hoisie/redis

* demo代码

        package main
        import "github.com/hoisie/redis"
        func main() {
            var client redis.Client
            var key = "hello"
            client.Set(key, []byte("world"))
            val, _ := client.Get("hello")
            println(key, string(val))
        }

