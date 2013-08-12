# scribe
@author `tabalt`

### 一、scribe

----------

#### 1、安装 gcc/gcc-c++ etc. 

    gcc –v # 需要版本 > 3.3.5

#### 2、安装 python
    
    



#### 3、安装 ruby
    
    wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz
    tar -zxvf ruby-1.9.3-p0.tar.gz
    cd ruby-1.9.3-p0
    ./configure
    make
    make install
    
#### 4、安装 libevent

    wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
    tar -zxvf libevent-2.0.21-stable.tar.gz
    cd libevent-2.0.21-stable
    ./configure
    make
    make install


#### 5、安装 boost

    # http://www.boost.org/users/history/version_1_45_0.html
    wget http://jaist.dl.sourceforge.net/project/boost/boost/1.45.0/boost_1_45_0.tar.gz
    tar -zxvf boost_1_45_0.tar.gz
    cd boost_1_45_0.tar.gz
    ./bootstrap.sh
    ./bjam
    ./bjam install

    # 配置环境变量
    export BOOST_ROOT=/usr/include/boost/
    # export LD_LIBRARY_PATH=/usr/include/boost/lib:/usr/lib:/usr/local/lib
    ldconfig -v


#### 6、安装 thrift

    #http://www.apache.org/dyn/closer.cgi?path=/thrift/0.7.0/thrift-0.7.0.tar.gz 
    wget http://mirror.bit.edu.cn/apache/thrift/0.7.0/thrift-0.7.0.tar.gz
    tar -zxvf thrift-0.7.0.tar.gz
    cd thrift-0.7.0
    ./configure --with-boost=/usr/include/boost/ --with-php-config=/usr/bin/php-config
    make
    make install

#### 7、安装 fb303

    cd thrift-0.7.0/contrib/fb303
    ./bootstrap.sh
    ./configure  --with-boost=/usr/include/boost
    make
    make install 

#### 8、安装 scribe

    wget https://codeload.github.com/facebook/scribe/zip/master
    mv master scribe-master.zip
    unzip scribe-master.zip
    cd scribe-master
    ./bootstrap.sh
    ./configure  --with-boost=/usr/include/boost
    make
    make install

#### 9、配置 scribe

    # test
    /usr/local/bin/scribed ~/scribe/scribe-master/examples/example1.conf


#### 10、scribe应用场景

