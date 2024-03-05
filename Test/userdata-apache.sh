#!bin/bash
yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1> this is a website from terraform</h1><br>  " > /var/www/html/index.html
