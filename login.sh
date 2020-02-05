#!/usr/bin/env bash
#
#file: login.sh
#desc: 登录主命令，主要是处理参数并通过调用core_login.sh发起登录
#author: shuchen
#email: h@iabc.io
#

Path=`dirname "$0"`                                   #get bin path
Path=`cd "$Path";pwd`                                 #change path to bin dir

#初始化登录用户名
user=""
#初始化登录主机IP地址
host=""
#初始化登录主机端口号（默认端口可以自己修改）
port=18822
#初始化用户登录密码
passwd=""
#初始化动态验证码
code=""
#初始化登录连接超时时间
timeout=30

while [ $# -gt 0 ]; 
do
    case $1 in
        --help)
            #TODO:使用帮助
            #usage
            exit 0
             ;;
        -u|--user)
            #设置外部传入的登录用户名
            user=$2
            shift 2
            ;;
        -h|--host)
            #设置外部传入的登录主机IP地址
            host=$2
            shift 2
            ;;
        -p|--port)
            #设置外部传入的登录主机端口号
            port=$2
            shift 2
            ;;
        -P|--|passwd|--password)
            #设置外部传入的用户登录密码
            passwd=$2
            shift 2
            ;;
        -c|--code)
            #设置外部传入的动态验证码
            code=$2
            shift 2
            ;;
        -t|--timeout)
            #设置外部传入的登录连接超时时间
            timeout=$2
            shift 2
            ;;
        *)
            #若未指定，其它参数一楼按动态验证码处理，以最后设置的为准
            code=$1
            shift
            ;;
    esac
done


if [ -z "$user" ]; then
   echo "user can't be null！usage : $0 -u \${some_user}"
   exit 1
fi

if [ -z "$host" ]; then
   echo "host can't be null！usage : $0 -h \${remote_host}"
   exit 1
fi

if [ -z "$port" ]; then
   echo "port can't be null！usage : $0 -p \${remote_port}"
   exit 1
fi

if [ -z "$passwd" ]; then
   echo "passwd can't be null！usage : $0 -P \${your_passwd}"
   exit 1
fi

#if [ -n "$code" ]; then
#    passwd="$passwd $code"
#fi
#echo $user
#echo $passwd
#echo $host
#echo $port
#echo $timeout

#这里是同级目录，用当前脚本的路径就可以了
${Path}/core_login.sh $host $port $timeout $user $passwd $code
