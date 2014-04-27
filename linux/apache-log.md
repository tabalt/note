# apache log


### access_log (访问日志)
---


* 日志示例

        216.35.116.91 - - [19/Aug/2000:14:47:37 -0400] "GET / HTTP/1.0" 200 654
        IP  浏览者标示 身份验证名字 时间 请求信息(方法 资源 协议) HTTP状态码 总字节数

* 配置访问日志

        CustomLog path/to/access_log combined
        CustomLog 文件路径 日志格式别名

* 定制访问日志

        LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
        LogFormat "%h %l %u %t \"%r\" %>s %b" common
        LogFormat "%{Referer}i -> %U" referer
        LogFormat "%{User-agent}i" agent


* 日志格式

        格式符  说明 
        %v                  进行服务的服务器的标准名字 ServerName，通常用于虚拟主机的日志记录中
        %h                  客户机的 IP 地址
        %l                  从identd服务器中获取远程登录名称，基本已废弃
        %u                  来自于认证的远程用户 
        %t                  连接的日期和时间
        %r                  HTTP请求的首行信息，典型格式是“METHOD RESOURCE PROTOCOL”，即“方法 资源 协议”
        %>s                 响应请求的状态代码
        %b                  传送的字节数 
        %{Referer}i         指明了该请求是从被哪个网页提交过来的。 
        %U                  请求的URL路径，不包含查询串。  
        \"%{User-Agent}i\"  此项是客户浏览器提供的浏览器识别信息。

* shell处理日志

        1、查看当天有多少个IP访问：
        awk '{print $1}' log_file|sort|uniq|wc -l
        2、查看某一个页面被访问的次数：
        grep "/index.php" log_file | wc -l
        3、查看每一个IP访问了多少个页面：
        awk '{++S[$1]} END {for (a in S) print a,S[a]}' log_file
        4、将每个IP访问的页面数进行从小到大排序：
        awk '{++S[$1]} END {for (a in S) print S[a],a}' log_file | sort -n
        5、查看某一个IP访问了哪些页面：
        grep ^111.111.111.111 log_file| awk '{print $1,$7}'
        6、去掉搜索引擎统计当天的页面：
        awk '{print $12,$1}' log_file | grep ^\"Mozilla | awk '{print $2}' |sort | uniq | wc -l
        7、查看2009年6月21日14时这一个小时内有多少IP访问：
        awk '{print $4,$1}' log_file | grep 21/Jun/2009:14 | awk '{print $2}'| sort | uniq | wc -l


### error_log (错误日志)
---

* 错误日志类别

        获知失效链接
        获知 CGI 错误
        获知用户认证错误

* 配置错误日志

        ErrorLog 错误日志文件名
        ErrorLog "|管道程序名"

* 错误日志记录等级

        LogLevel warn
        紧急程度    等级          说明
            1     emerg     出现紧急情况使得该系统不可用，如系统宕机等
            2     alert     需要立即引起注意的情况
            3     crit      危险情况的警告
            4     error     除了emerg、alert、crit的其他错误
            5     warn      警告信息
            6     notice    需要引起注意的情况，但不如error、warn重要
            7     info      值得报告的一般消息
            8     debug     由运行于debug模式的程序所产生的消息
        如果指定了等级 warn，那么就记录紧急程度为1至5的所有错误信息。
    


