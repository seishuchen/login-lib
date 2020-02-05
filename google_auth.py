#!/usr/bin/env python
# coding:utf8
 
#
#file: google_auth.py
#desc: 谷歌动态验证码获取实现方案（基础）
#author: shuchen
#email: h@iabc.io
#
 
import hmac
import base64
import struct
import hashlib
import time
import sys
 
def get_hotp_token(secret, intervals_no):
    key = base64.b32decode(secret, True)
    msg = struct.pack(">Q", intervals_no)
    h = hmac.new(key, msg, hashlib.sha1).digest()
    o = ord(h[19])& 15
    h = (struct.unpack(">I", h[o:o+ 4])[0]& 0x7fffffff)% 1000000
    return h
 
 
def get_totp_token(secret):
    return get_hotp_token(secret, intervals_no=int(time.time())// 30)

def get_token():
    secret = sys.argv[1];
    return get_totp_token(secret)
 
 
def main():
    return get_token()
 
if __name__ =='__main__':
    print main()
 
 
