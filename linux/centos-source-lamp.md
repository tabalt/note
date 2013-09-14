# centos source 安装 lamp 环境

### 一、熟悉系统环境

----------

    #查看版本号
    cat /etc/issue      
    #查看所有硬件的型号
    dmidecode | more
    #查看memory info
    cat /proc/meminfo | more
    #查看CPU info
    cat /proc/cpuinfo
    #查看磁盘信息  
    df -lh

### 二、准备工作

----------

    # 更新系统时间  
    ntpdate time.windows.com;/sbin/hwclock -w

    #备份并替换系统的repo文件
    sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    cd /etc/yum.repos.d/
    sudo wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
    sudo mv CentOS6-Base-163.repo CentOS-Base.repo

    #更新下载源
    sudo yum clean all
    sudo yum makecache
    sudo yum update

    #测试是否成功
    sudo yum install vim*

    #修改yum配置文件中python版本 (No module named yum)
    whereis python 
        查看python版本
    sudo vim /usr/bin/yum
        将 #!/usr/bin/python 修改为 #!/usr/bin/python2.4(具体版本)

    # source in /usr/local/src/, soft installed in /usr/local/softname
    cd /usr/local/src/

    # 下载软件包

    # 下载php
    wget http://cn2.php.net/distributions/php-5.3.27.tar.gz
    # 下载apache
    wget http://mirrors.cnnic.cn/apache/httpd/httpd-2.4.6.tar.gz
    # 下载MySQL
    wget http://cdn.mysql.com/Downloads/MySQL-5.5/mysql-5.5.33.tar.gz
    # 下载cmake（MySQL编译工具）
    wget http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
    # 下载apr-util（Apache库文件）
    wget http://mirror.bit.edu.cn/apache/apr/apr-util-1.5.2.tar.gz
    # 下载apr（Apache库文件）
    wget http://mirror.bit.edu.cn/apache/apr/apr-1.4.8.tar.gz
    #下载libmcrypt（PHPlibmcrypt模块）
    wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz


    # http://cn2.php.net/get/php-5.3.27.tar.gz/from/a/mirror
    # http://dev.mysql.com/downloads/mirror.php?id=414081
    # http://mirrors.cnnic.cn/apache/httpd/
    # http://www.cmake.org/cmake/resources/software.html
    # http://mirrors.cnnic.cn/apache/apr/

    # 安装编译工具及库文件

    yum install make apr* autoconf automake gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel gd  kernel keyutils  patch perl kernel-headers compat* mpfr cpp glibc libgomp libstdc++-devel ppl cloog-ppl keyutils-libs-devel libcom_err-devel libsepol-devel libselinux-devel krb5-devel zlib-devel libXpm* freetype libjpeg* libpng* php-common php-gd ncurses* libtool* libxml2 libxml2-devel patch 

### 三、安装 lamp 环境

----------

#### 1、安装libmcrypt
     
    tar zxvf  libmcrypt-2.5.7.tar.gz #解压
    cd  libmcrypt-2.5.7 #进入目录 
    ./configure    #配置 
    make           #编译
    make install   #安装

#### 2、安装cmake
    
    tar zxvf cmake-2.8.7.tar.gz 
    cd cmake-2.8.7
    ./configure
    make
    make install

#### 3、安装apr

    tar zxvf  apr-1.4.6.tar.gz 
    cd apr-1.4.6 
    ./configure --prefix=/usr/local/apr
    make
    make install

#### 4、安装apr-util

    tar zxvf apr-util-1.4.1.tar.gz
    cd apr-util-1.4.1 
    ./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/bin/apr-1-config
    make
    make install

#### 5、安装mysql

    groupadd mysql  #添加mysql组
    #创建用户mysql并加入到mysql组，不允许mysql用户直接登录系统
    useradd -g mysql mysql -s /bin/false     
    mkdir -p /data/mysql  #创建MySQL数据库存放目录
    chown -R mysql:mysql /data/mysql   #设置MySQL数据库目录权限
    mkdir -p /usr/local/mysql #创建MySQL安装目录
    cd /usr/local/src
    tar zxvf mysql-5.5.21.tar.gz  #解压
    cd mysql-5.5.21
    cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql  -DMYSQL_DATADIR=/data/mysql  -DSYSCONFDIR=/etc   #配置
    make #编译
    make install  #安装
    cd /usr/local/mysql
    #拷贝配置文件（注意：/etc目录下面默认有一个my.cnf，直接覆盖即可）
    cp ./support-files/my-huge.cnf /etc/my.cnf   
    vi /etc/my.cnf   #编辑配置文件,在 [mysqld] 部分增加
        datadir = /data/mysql  #添加MySQL数据库路径
    ./scripts/mysql_install_db --user=mysql  #生成mysql系统数据库
    cp ./support-files/mysql.server  /etc/rc.d/init.d/mysqld  #把Mysql加入系统启动
    chmod 755 /etc/init.d/mysqld   #增加执行权限
    chkconfig mysqld on  #加入开机启动
    vi /etc/rc.d/init.d/mysqld  #编辑
        basedir = /usr/local/mysql   #MySQL程序安装路径
        datadir = /data/mysql  #MySQl数据库存放目录
    service mysqld start  #启动
    vi /etc/profile   #把mysql服务加入系统环境变量：在最后添加下面这一行
        export PATH=$PATH:/usr/local/mysql/bin
    # 下面这两行把myslq的库文件链接到系统默认的位置，这样你在编译类似PHP等软件时可以不用指定mysql的库文件地址。 
    ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
    ln -s /usr/local/mysql/include/mysql /usr/include/mysql
    shutdown -r now     #需要重启系统，等待系统重新启动之后继续在终端命令行下面操作
    mysql_secure_installation
    #设置Mysql密码   根据提示按Y 回车输入2次密码 
    #或者直接修改密码
    /usr/local/mysql/bin/mysqladmin -u root -p password "123456" #修改密码 
    service mysqld restart  #重启

    到此，mysql安装完成！


#### 6、安装apache2

    tar -zvxf httpd-2.4.1.tar.gz
    cd httpd-2.4.1  
    mkdir -p /usr/local/apache2  #创建安装目录
    ./configure  --prefix=/usr/local/apache2 --with-apr=/usr/local/apr  --with-apr-util=/usr/local/apr-util --with-ssl  --enable-ssl --enable-module=so  --enable-rewrite --enable-cgid --enable-cgi
    make
    make install
    /usr/local/apache2/bin/apachectl -k start
    vi /usr/local/apache2/conf/httpd.conf
        #ServerName www.example.com:80
        ServerName www.osyunwei.com:80
        找到：DirectoryIndex index.html 
        修改为：DirectoryIndex index.html index.php
        找到：Options Indexes FollowSymLinks 
        修改为：Options FollowSymLinks    #不显示目录结构
        找到AllowOverride None  
        修改为：AllowOverride All   #开启apache支持伪静态，有两处都做修改 
        
        #取消前面的注释，开启apache支持伪静态 
        LoadModule rewrite_module modules/mod_rewrite.so   
        vi /etc/profile  #添加apache服务系统环境变量
        # 在最后添加下面这一行 
            export PATH=$PATH:/usr/local/apache2/bin 
        #把apache加入到系统启动
        cp /usr/local/apache2/bin/apachectl /etc/rc.d/init.d/httpd
        vi /etc/init.d/httpd
        #编辑文件 在#!/bin/sh下面添加以下两行
            #chkconfig:2345 10 90 
            #descrption:Activates/Deactivates Apache Web Server 
        chown daemon.daemon -R /usr/local/apache2/htdocs #更改目录所有者
        chmod 700 /usr/local/apache2/htdocs -R  #更改apache网站目录权限
        chkconfig httpd on #设置开机启动
        /etc/init.d/httpd start
        service httpd restart

    
#### 7、安装php

    tar -zvxf php-5.3.10.tar.gz
    cd php-5.3.10  
    mkdir -p /usr/local/php5  #建立php安装目录
    ./configure  --prefix=/usr/local/php5 --with-config-file-path=/usr/local/php5/etc --with-apxs2=/usr/local/apache2/bin/apxs --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock --with-gd --with-iconv --with-freetype --with-jpeg --with-png --with-zlib --with-libxml  --enable-xml --enable-discard-path --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem  --enable-inline-optimization --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-force-cgi-redirect --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --with-mime-magic --enable-suhosin --enable-session --with-mcrypt  #配置
    make   #编译
    make install    #安装
 
    mkdir /usr/local/php5/etc
    cp php.ini-production /usr/local/php5/etc/php.ini  #复制php配置文件到安装目录
    rm -rf /etc/php.ini #删除系统自带的配置文件
    ln -s  /usr/local/php5/etc/php.ini   /etc/php.ini   #创建配置文件软链接

    vi /usr/local/php5/etc/php.ini    #编辑
        #找到：
        ;open_basedir =  
        #修改为：
        open_basedir = .:/tmp/   #防止php木马跨站
        #找到：disable_functions =
        修改为：
        disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid,posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname

        #列出PHP可以禁用的函数，如果某些程序需要用到这个函数，可以删除，取消禁用。
        #找到：
        ;date.timezone =
        #修改为：
        date.timezone = PRC
        #找到：
        expose_php = On  
        #修改为：
        expose_php = OFF  #禁止显示php版本的信息
        #找到：
        display_errors = On 
        #修改为：
        display_errors = OFF  #关闭错误提示


#### 8、配置apache支持php

    vi /usr/local/apache2/conf/httpd.conf  #编辑apache配置文件 
    在LoadModule php5_module        modules/libphp5.so这一行下面添加

    AddType application/x-httpd-php .php
    service httpd restart    #重启apache
    service mysqld restart   #重启mysql


#### 9、测试

    cd  /usr/local/apache2/htdocs
    vi index.php
        <?php phpinfo(); ?> 

    #确保改目录为以下权限 
    chown daemon.daemon -R /usr/local/apache2/htdocs
    chmod -R 700 /usr/local/apache2/htdocs 



    http://wenku.baidu.com/view/426bac19a216147917112865.html