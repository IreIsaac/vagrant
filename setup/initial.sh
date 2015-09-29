#!/bin/bash

apt-get -y update
# Install basic tools
apt-get install -qq curl unzip git-core ack-grep software-properties-common build-essential
# Update
apt-get -y update
# Install apache, php, samba
apt-get -y install apache2 php5 samba
# restart apache
service apache2 restart
# add mysql repo
add-apt-repository -y ppa:ondrej/mysql-5.6
# update again
apt-get -y update
# Mysql set some defaults
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
# install mysql
apt-get install -qq mysql-server-5.6
# mysql available to everyone, so you can reach it from you PC running vagrant
sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
# set up some mysql users
/usr/bin/mysql -uroot -proot -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;FLUSH PRIVILEGES;"
/usr/bin/mysql -uroot -proot -e "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'"
/usr/bin/mysql -uroot -proot -e "GRANT ALL ON *.* TO 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'"
# Mysql install complete so lets retart, YAY!
service mysql restart
# What the hell, let update again
apt-get -y update
# now lets prepare samba
cp /etc/samba/smb.conf /etc/samba/smb.conf.orig
rm -f /etc/samba/smb.conf
cd /etc/samba/
wget http://raw.githubusercontent.com/IreIsaac/vagrant/master/setup/smb.conf
cd ~
service smbd reload
service smbd restart
#clean up some permissions
adduser vagrant www-data
chown vagrant:www-data /var/www -R