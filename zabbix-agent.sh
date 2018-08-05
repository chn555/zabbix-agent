#!/bin/bash


setenforce 0
firewall-cmd --add-port=10050/tcp --permanent
rpm -ivh https://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm

 yum install zabbix-agent

 sed -i -e 's/# EnableRemoteCommands=0/EnableRemoteCommands=0/g' /etc/zabbix/zabbix_agent.conf
 sed -i -e 's/Server=127.0.0.1/Server=10.0.0.5/g' /etc/zabbix/zabbix_agent.conf
