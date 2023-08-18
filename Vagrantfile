Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provision :shell, 
  path: "vagrant-build.sh",
  keep_color: true
  config.vm.synced_folder ".", "/dataverse-demo", :mount_options => ["dmode=777","fmode=666"]
  config.vm.network :forwarded_port, host: 99, guest: 80
  config.vm.network :forwarded_port, host: 9999, guest: 8080
  config.vbguest.auto_update = false
  config.vm.define 'vagrant-docker' do |t|
    config.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 4096]
    end
  end
end
