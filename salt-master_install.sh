#!/bin/bash
#########################################################################
# File Name: salt-master_install.sh
# Author: liangshaohua
# mail: youxiu543@163.com
# Created Time: Mon 19 Aug 2019 08:54:22 PM CST
#########################################################################
set -e

#请输入代码

yum install https://mirrors.aliyun.com/saltstack/yum/redhat/salt-repo-latest-2.el7.noarch.rpm  -y
sed -i "s/repo.saltstack.com/mirrors.aliyun.com\/saltstack/g" /etc/yum.repos.d/salt-latest.repo
yum repolist
yum install salt-master salt-minion -y
systemctl enable salt-master
systemctl enable salt-minion

read -p "请输入master的IP:" masterIP
sed -i "/^#master: salt/cmaster: ${masterIP}"  /etc/salt/minion
mkdir -p /srv/salt/{base,test,dev,prod}
sed -i '662a file_roots:\
  base:\
    - /srv/salt/base\
  dev:\
    - /srv/salt/dev\
  test:\
    - /srv/salt/test\
  prod:\
    - /srv/salt/prod'  /etc/salt/master
systemctl start salt-master
systemctl start salt-minion
