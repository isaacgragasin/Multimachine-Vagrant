# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  
  BOX_IMAGE = "ubuntu/impish64"
  BASE_NETWORK = "10.10.20"
  
  BOX_CHK_UPDATE = false
  SSH_INSERT_KEY = false
  PROXY_ENABLE = false
  VB_CHK_UPDATE = false
  
  PROXY_ENABLE = true
  PROXY_HTTP = "http://10.0.2.2:5865"
  PROXY_HTTPS = "http://10.0.2.2:5865"
  PROXY_EXCLUDE = "localhost,127.0.0.1"
  
  config.vm.synced_folder "www/", "/var/www"

  config.vm.define "web" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.network "private_network", ip: "#{BASE_NETWORK}.10", virtualbox_intnet: true
    subconfig.vm.network "forwarded_port", guest: 80, host: 9080
    
    subconfig.vm.hostname = "mmweb.cpt.local"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "MMWeb"
      vb.memory = "1024"
      vb.cpus = 1
      vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
      vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
      #vb.gui = true #enable only for debugging
    end
    
    subconfig.vm.box_check_update = BOX_CHK_UPDATE
    subconfig.ssh.insert_key = SSH_INSERT_KEY
    
    if PROXY_ENABLE == true
      #only use with plugin vagrant-proxy
      #print "setting proxy config"
      subconfig.proxy.http = PROXY_HTTP
      subconfig.proxy.https = PROXY_HTTPS
      subconfig.proxy.no_proxy = PROXY_EXCLUDE
      
      if Vagrant.has_plugin?("vagrant-vbguest")
        subconfig.vbguest.auto_update = VB_CHK_UPDATE
      end
    end
    
    subconfig.vm.provision "shell", path: "./scripts/provision_update.sh"
    subconfig.vm.provision "shell", path: "./scripts/provision_apache.sh"
    subconfig.vm.provision "shell", path: "./scripts/provision_php.sh"
  end
  
  config.vm.define "db" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.network "private_network", ip: "#{BASE_NETWORK}.15", virtualbox_intnet: true
    
    subconfig.vm.hostname = "mmdb.cpt.local"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "MMDb"
      vb.memory = "1024"
      vb.cpus = 1
      vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
      vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
      #vb.gui = true #enable only for debugging
    end

    subconfig.vm.box_check_update = BOX_CHK_UPDATE
    subconfig.ssh.insert_key = SSH_INSERT_KEY
    
    if PROXY_ENABLE == true
      #only use with plugin vagrant-proxy
      #print "setting proxy config"
      subconfig.proxy.http = PROXY_HTTP
      subconfig.proxy.https = PROXY_HTTPS
      subconfig.proxy.no_proxy = PROXY_EXCLUDE
      
      if Vagrant.has_plugin?("vagrant-vbguest")
        subconfig.vbguest.auto_update = VB_CHK_UPDATE
      end
    end
    
    subconfig.vm.provision "shell", path: "./scripts/provision_update.sh"
    subconfig.vm.provision "shell", path: "./scripts/provision_mysql.sh"
  end
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
