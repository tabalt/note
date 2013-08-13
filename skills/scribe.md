# Scribe 安装
@author pmpen

* 安装gcc
* 安装ruby
* 安装python
* 安装libevent
<pre><code>
$wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
$cd libevent-2.0.1-stable
$./configure 
$make && make install
</code></pre>
* 安装boost
<pre><code>
$wget http://sourceforge.net/projects/boost/files/boost/1.54.0/boost_1_54_0.tar.gz
$tar -zxvf boost_1_54_0.tar.gz
$cd boost_1_54_0
$./bootstrap.sh
$./bjam 
$./bjam install
\#如果提示"patchlevel.h：没有那个文件或目录",然后重新安装
\#sudo apt-get install python-dev
\#如果提示"bzlib.h：没有那个文件或目录",安装然后重新安装
\#sudo apt-get install libbz2-dev
</code></pre>

* 安装thrift
<pre><code>
$wget http://apache.etoak.com/thrift/0.9.0/thrift-0.9.0.tar.gz
$cd thrift-0.9.0
$./configure --with-boost=/usr/local/include/boost --with-php-config=/usr/bin/php-config #找到php-config文件位置
$make
$make install
\#./configure后查看C++库安装提示,如果出现"Build TQTcpServer (Qt) .... : no ",这里可能导致安装scribe是报错(不行不行啊不行)
\#安装apt-get install qt4-dev-tools
</pre></code>

* 安装 fb303
<pre><code>$cd ./contrib/fb303/ #fb303在thrift.9.0/contrib/fb303下面
$./bootstrap.sh --with-boost=/usr/local/include/boost/
$make
$make install
</pre></code>

* 安装scribe
<pre><code>
\#设置环境变量
$export BOOST_ROOT=/usr/local/include/boost
$export LD_LIBRARY_PATH=/usr/local/include/boost/lib::/usr/lob:/usr/local/lib
$ldconfig -v
\#下载https://github.com/facebook/scribe
$cd scribe-master
$./bootstrap.sh 
$./configure  --with-boost=/usr/local/include/boost
$make
$make install
</pre></code>
