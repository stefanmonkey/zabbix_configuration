#!/usr/bin/env python
# -*- coding:utf-8 -*-
import json
import subprocess
import os, sys
import re

def config_parser(conf, para):
	result = []
	input_conf = open(conf, 'r').readlines()

	p = re.compile(r'(^%s (\S)+)' % para)

	for line in input_conf:
		iter = p.finditer(line)
		for m in iter:
			result.append(m.group())

	return result[0]

init_path = '/etc/init.d/'
redis_init = [init for init in os.listdir(init_path) if 'redis' in init]

redis_para = []

for init in redis_init:
	redis_conf = config_parser(os.path.join(init_path, init), 'conf'.upper()).split("=")[1]
	print redis_conf
	ipaddr = config_parser(redis_conf, 'bind').split()[1]
    port   = config_parser(redis_conf, 'port').split()[1]
    dict_temp = {'port' : port, 'ipaddr': ipaddr}
    redis_para.append(dict_temp)

json_data = {"data": []}

for para in redis_para:
        
	dic_content = {
	"{#REDIS_PORT}":  para['port'],
	"{#REDIS_IPADDR": para['ipaddr']
	}

	json_data['data'].append(dic_content)

result = json.dumps(json_data)
print result