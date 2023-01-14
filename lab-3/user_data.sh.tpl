#!/bin/bash
yum -y update
yum -y install httpd
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<h1>This page is build using the <font color="red">Terraform</font> template</h1>
<h4>Server Owner is: ${first_name} ${last_name}</h4>
<br>
%{ for name in other_names ~}
  <h4>${first_name} ${last_name} says HELLO to: ${name}</h4>
%{ endfor ~}
</html>
EOF
service httpd start
chkconfig httpd on
