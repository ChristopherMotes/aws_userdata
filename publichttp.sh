#!/bin/bash
yum -y update
yum -y install httpd
chkconfig httpd on
perl -pe 's/Amazon/Motes Public/g' /var/www/error/noindex.html > /var/www/html/index.html
service httpd start
