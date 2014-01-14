# shell

@author `tabalt`

### 一、代码片段

----------

* md5

        str="source string"
        md5_str=`echo -n $str | md5sum | cut -d ' ' -f1`
        echo $str
        # http://blog.chinaunix.net/uid-20613650-id-3269470.html

* 判断文件是否存在

        shell判断文件,目录是否存在或者具有权限 
        #!/bin/sh 
        
        myPath="/var/log/httpd/" 
        myFile="/var /log/httpd/access.log" 
        
        # 这里的-x 参数判断$myPath是否存在并且是否具有可执行权限 
        if [ ! -x "$myPath"]; then 
        mkdir "$myPath" 
         fi 
         
        # 这里的-d 参数判断$myPath是否存在 
        if [ ! -d "$myPath"]; then 
        mkdir "$myPath" 
        fi 
        
        # 这里的-f参数判断$myFile是否存在 
        if [ ! -f "$myFile" ]; then 
        touch "$myFile" 
        fi 
        
        # 其他参数还有-n,-n是判断一个变量是否是否有值 
        if [ ! -n "$myVar" ]; then 
        echo "$myVar is empty" 
        exit 0 
        fi 
        
        # 两个变量判断是否相等 
        if [ "$var1" = "$var2" ]; then 
        echo '$var1 eq $var2' 
        else 
        echo '$var1 not eq $var2' 
        fi 

        -f 和-e的区别 
        Conditional Logic on Files 

        -a file exists. 
        -b file exists and is a block special file. 
        -c file exists and is a character special file. 
        -d file exists and is a directory. 
        -e file exists (just the same as -a). 
        -f file exists and is a regular file. 
        -g file exists and has its setgid(2) bit set. 
        -G file exists and has the same group ID as this process. 
        -k file exists and has its sticky bit set. 
        -L file exists and is a symbolic link. 
        -n string length is not zero. 
        -o Named option is set on. 
        -O file exists and is owned by the user ID of this process. 
        -p file exists and is a first in, first out (FIFO) special file or 
        named pipe. 
        -r file exists and is readable by the current process. 
        -s file exists and has a size greater than zero. 
        -S file exists and is a socket. 
        -t file descriptor number fildes is open and associated with a 
        terminal device. 
        -u file exists and has its setuid(2) bit set. 
        -w file exists and is writable by the current process. 
        -x file exists and is executable by the current process. 
        -z string length is zero.       

        # http://www.cnblogs.com/sunyubo/archive/2011/10/17/2282047.html

* shell中if-elif-else用法

        #!/bin/bash 

        function myfun()
        {
            echo "myfun"
            return 0
        }

        #判断标准输入中是否包含hello
        #if后面接命令
        if grep "hello" >/dev/null 2>&1 ;then
            echo "include hello"
        else
            echo "don't include hello"
        fi

        #if后面接函数调用
        if myfun ;then
            echo "myfun success"
        else
            echo "myfun error"
        fi

        #if后面接test语句 
        read T
        if [ "$T" -lt "10" ] ;then 
            echo " T < 10"
        elif [ "$T" -le "20" -a "$T" -ge "10" ] ;then 
            #[]中应该使用-a -o 而不是使用&& ||
            echo " T >= 10 && T <= 20 "
        else 
            echo " T > 20"
        fi

        #http://ldl.wisplus.net/2011/04/24/shell%E4%B8%ADif-elif-else%E7%94%A8%E6%B3%95/