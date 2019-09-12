#!/bin/bash
#########################################################################
# File Name: salt-minion_install.sh
# Author: liangshaohua
# mail: youxiu543@163.com
# Created Time: Mon 19 Aug 2019 08:46:53 PM CST
#########################################################################
set -e

#请输入代码
yum install https://mirrors.aliyun.com/saltstack/yum/redhat/salt-repo-latest-2.el7.noarch.rpm  -y
sed -i "s/repo.saltstack.com/mirrors.aliyun.com\/saltstack/g" /etc/yum.repos.d/salt-latest.repo
yum repolist
yum install salt-minion -y
systemctl enable salt-minion

read -p "请输入master的ip:" masterIP
sed -i "/^#master: salt/cmaster: ${masterIP}"  /etc/salt/minion
systemctl start salt-minion
