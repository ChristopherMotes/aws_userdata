#!/bin/bash
yum -y update
echo "*filter" > /etc/sysconfig/iptables
echo ":INPUT DROP [0:0]" >> /etc/sysconfig/iptables
echo ":FORWARD DROP [0:0]" >> /etc/sysconfig/iptables
echo ":OUTPUT ACCEPT [0:0]" >> /etc/sysconfig/iptables
echo ":http - [0:0]" >> /etc/sysconfig/iptables
echo "-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A INPUT -i lo -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A INPUT -d 127.0.0.0/8 ! -i lo -j DROP" >> /etc/sysconfig/iptables
echo "-A INPUT -s 70.117.65.133/32 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A INPUT -p tcp -m tcp --dport 80 -j http" >> /etc/sysconfig/iptables
echo "-A http -s 10.10.129.0/24 -j ACCEPT" >> /etc/sysconfig/iptables
echo "COMMIT" >> /etc/sysconfig/iptables
chkconfig iptables on
service iptables start
yum -y install httpd
chkconfig httpd on
INSID=`curl http://169.254.169.254/latest/meta-data/instance-id/`
perl -pe "s/Amazon/Motes Public $INSID/g" /var/www/error/noindex.html > /var/www/html/index.html
service httpd start
