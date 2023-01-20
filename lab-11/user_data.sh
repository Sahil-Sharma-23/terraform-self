#!/bin/bash
yum -y update
yum -y install httpd

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Build using the power of</font> <font color="red">TERRAFORM</font></h2>
<br>
<font color="green">Server PrivateIP: </font><font color="aqua">$myip</font>
<br><br>
<font color="blue"><strong>VERSION 1.0</strong></font>
</body>
</html>
EOF

service httpd start
chkconfig httpd on
