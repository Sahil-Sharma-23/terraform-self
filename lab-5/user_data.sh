#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<h1>VERSION: 4.0</h1>
<h4>Final version which has <font color=red>Zero-Downtime</font> and <font color=red>Elastic IP</font></h4>
<h1>This page is build using the <font color="red">Terraform</font></h1>
<h4>Server Owner is: Sahil Sharma</h4>
<br>
</html>
EOF
service httpd start
chkconfig httpd on
