# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.ssh.forward_agent = true
  
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.network :private_network, ip: "192.168.33.33"
  
  config.vm.provider "virtualbox" do |v|
        v.name = "mager"
        v.customize ["modifyvm", :id, "--memory", "4096"]
        v.customize ["modifyvm", :id, "--cpus",2]
        v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

    $script = <<SCRIPT
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
SCRIPT


    config.vm.provision "shell", inline: $script


end
