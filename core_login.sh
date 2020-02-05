#!/usr/bin/expect
#
#file: core_login.sh
#desc: 最底层的expect语法交互登录脚本
#      只提供最基础的登录功能
#author: shuchen
#email: h@iabc.io
#

#设置默认连接超时时间为默认30秒
set timeout 30

#设置远程登录的IP地址
set host [lindex $argv 0]
#设置远程登录的端口，ssh默认情况下是22，
#这里也要求传入，由上层控制
set port [lindex $argv 1]
#设置连接超时时间
set timeout [lindex $argv 2]
#设置登录用户
set user [lindex $argv 3]
#设置用户登录密码(真实登录密码)
set passwd [lindex $argv 4]
#设置动态验证码（一般是谷歌的）
set code [lindex $argv 5]

if { $code != "" } {
    #判断动态验证码是否有效，若有效则拼接到用户密码后面
    set passwd "$passwd $code"
}

#发起登录命令
spawn ssh -p$port -l $user $host
#自动交互式输入密码
expect {
-re "Are you sure you want to continue connecting (yes/no)?" {
send "yes\r"
expect "assword:"
send "$passwd\r"
} -re "assword:" {
send "$passwd\r"
} -re "Permission denied, please try again." {
exit
} -re "Connection refused" {
exit
} timeout {
exit
} eof {
exit
}
}

interact
