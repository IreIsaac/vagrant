#!/bin/bash

apt-get -y update
apt-get install -qq curl unzip git-core ack-grep software-properties-common build-essential
apt-get -y update
apt-get -y install apache2 php5 samba
service apache2 restart
add-apt-repository -y ppa:ondrej/mysql-5.6
apt-get -y update
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
apt-get install -qq mysql-server-5.6
sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
/usr/bin/mysql -uroot -proot -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;FLUSH PRIVILEGES;"
/usr/bin/mysql -uroot -proot -e "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'"
/usr/bin/mysql -uroot -proot -e "GRANT ALL ON *.* TO 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'"
service mysql restart
apt-get -y update