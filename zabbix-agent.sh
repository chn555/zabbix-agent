#!/bin/bash
sed -i -e 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

read -p "Enter hostname : " hostname
echo $hostname > /etc/hostname
setenforce 0
firewall-cmd --add-port=10050/tcp --permanent
rpm -ivh https://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm

yum install zabbix-agent -y

sed -i -e 's/# EnableRemoteCommands=0/EnableRemoteCommands=0/g' /etc/zabbix/zabbix_agentd.conf
sed -i -e 's/ServerActive=127.0.0.1/ServerActive=10.0.0.5/g' /etc/zabbix/zabbix_agentd.conf
sed -i -e "s/Hostname=Zabbix server/Hostname=$hostname/g" /etc/zabbix/zabbix_agentd.conf

systemctl enable zabbix-agent
systemctl start zabbix-agent


echo "Done"
