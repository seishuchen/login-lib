#!/usr/bin/env bash
#
#file: demo_notoken.sh
#desc: 不带动态验证码的登陆示例
#author: shuchen
#email: h@iabc.io
#

Path=`dirname "$0"`                                   #get bin path
Path=`cd "$Path";pwd`                                 #change path to bin dir

#这里根据实际情况设置登录脚本根目录
export LOGIN_LIB_PATH="$Path"                              #set login core lib path

#登录主机IP地址
host="192.168.3.228"
#登录主机端口号
port=22
#登录用户名
user="nebula"
#用户登录密码
passwd="nebula"
#登录超时时间
timeout=30
#动态验证码秘钥(一般是谷歌的),没有设置为空串""
secret=""
#动态验证码临时变量，没有设置为空串
code=""


if [ -n "$secret" ]; then
    #秘钥不为空时获取动态验证码
    code=`python $LOGIN_LIB_PATH/google_auth.py $secret`
fi

$LOGIN_LIB_PATH/login.sh -u $user -h $host -p $port -P $passwd -t $timeout $code
