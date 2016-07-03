yum -y update
yum -y install httpd
chkconfig on httpd
perl -pe 's/Amazon/Motes Public/g' /var/www/error/noindex.html > /var/www/html/index.html
service httpd start
