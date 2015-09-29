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

    config.vm.provision "shell", path: "https://raw.githubusercontent.com/IreIsaac/vagrant/master/setup/initial.sh"

end
