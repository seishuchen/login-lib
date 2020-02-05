#!/usr/bin/env bash
Path=`dirname "$0"`                                   #get bin path
Path=`cd "$Path";pwd`                                 #change path to bin dir

./core_login.sh 192.168.3.228 22 60 nebula nebula ""
