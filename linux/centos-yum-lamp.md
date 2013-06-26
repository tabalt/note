# centos yum 安装 lamp 环境

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

    #更新系统时间  
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

### 三、安装 lamp 环境

----------

#### 1、安装apache

    sudo yum install httpd httpd-devel  
    sudo vim /etc/httpd/conf/httpd.conf 
        #修改主机名
        #ServerName www.example.com:80  ->   ServerName localhost:80
        #启用 rewrite
        #LoadModule rewrite_module modules/mod_rewrite.so  取消注释
        AllowOverride None  ->  AllowOverride All
        #下面这行 注释去掉
        #NameVirtualHost *:80
        :wq
    sudo apachectl start


#### 2、安装php

    #安装命令
    sudo yum install php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml php-pear php-soap
    #配置
    sudo vim /etc/php.ini
        memory_limit = 1024M
        upload_max_filesize= 500M
        post_max_size = 500M
    sudo apachectl restart
    sudo vim /var/www/html/test.php
        <?php 
            phpinfo();
        ?>
    #安装pear
    sudo yum install php-pear
    #安装php的radius扩展 
    sudo pecl install radius
    sudo vim /etc/php.ini
        extension=radius.so
    #站点配置
    cd /etc/httpd/conf.d/
    sudo vim www.domian.com.conf


#### 3、centos 5.4 yum安装php 5.3(默认源为5.1)

    #查看当前php版本
    php -v 
    #安装php
    rpm --import http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-andy
    wget -P /etc/yum.repos.d/ http://repo.webtatic.com/yum/webtatic.repo
    sudo yum --enablerepo=webtatic install php php-mysql php-common php-gd php-mbstring php-mcrypt php-devel php-xml php-pear php-soap
