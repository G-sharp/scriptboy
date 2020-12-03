# !/usr/bin/python
# encoding:utf-8
# This is a python script for NJUer to login in Internet service.
# Author: Gsharp
# Created: 2019-12-12
# Version: 2.0
# Modified: 2020-12-03
import sys
import requests
import json
import hashlib


def md5(str):
    m = hashlib.md5()
    m.update(str)
    return m.hexdigest()

if __name__ == "__main__":

    if len(sys.argv) <= 2:
        if len(sys.argv) > 1:
            if sys.argv[1] == 'logout':
                print(requests.post("http://p.nju.edu.cn/portal_io/logout",0).text)
        else:
            print("Please run as : \n \t python3 request.py [username] [passwd]")
        exit(1) 
    seed = 100
    # Your Username
    username = '' if (sys.argv[1] == '' ) else sys.argv[1]  
    # Your Password
    passwd = ''    if (sys.argv[2] == '' ) else sys.argv[2]
    
   
    # Get Challenge
    res_challenge = requests.post('http://p.nju.edu.cn/portal_io/getchallenge')
    challenge = json.loads(res_challenge.text)['challenge']

    key = chr(seed)
    key += passwd
    key = key.encode('utf-8')
    for i in range(0, len(challenge), 2):
        str_hex = challenge[i:i+2]
        dec = int(str_hex, 16)
        key += bytes([dec])

    #print(key)
    hash = md5(key)    
    chappassword = ('0' if (seed < 16) else '' ) + hex(seed)[-2:] + hash

    # Login
    postdata={'username': username, 'password': chappassword, 'challenge': challenge}
    r=requests.post('http://p.nju.edu.cn/portal_io/login',data=postdata)
    json_object = json.loads(r.text)
    print(json.dumps(json_object, indent=2,ensure_ascii=False))
