
kube_master = {
        :name => "kube-master",
        :box => "bento/centos-7.4",
        :box_version => "201803.24.0 ",
        :mem => "2048",
        :cpu => "2"
    }

kube_worker = {
        :name => "kube-worker",
        :count => 3,
        :box => "bento/centos-7.4",
        :box_version => "201803.24.0 ",
        :mem => "4096",
        :cpu => "2",
        :rootdisksize => '20GB'
    }

Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "install.sh"

  config.vm.define "kube_master" do |master|
    master.vm.box = kube_master[:box]
    master.vm.box_version = kube_master[:box_version]
    master.vm.hostname = kube_master[:name]
    master.vm.network :private_network, type: "dhcp"
    master.vm.boot_timeout = 600
    master.vm.provider "virtualbox" do |v|
        v.name = kube_master[:name]
        v.customize ["modifyvm", :id, "--memory", kube_master[:mem]]
        v.customize ["modifyvm", :id, "--cpus", kube_master[:cpu]]
    end
    master.vm.provision "shell", path: "install-master.sh"
  end

  (1..kube_worker[:count]).each do |i|
    config.vm.define "kube_worker-#{i}" do |worker|
      worker.vm.box = kube_worker[:box]
      worker.vm.box_version = kube_worker[:box_version]
      worker.vm.hostname = "#{kube_worker[:name]}-#{i}"
      worker.vm.network :private_network, type: "dhcp"
      worker.vm.boot_timeout = 600
      worker.vm.provider "virtualbox" do |v|
        v.name = "#{kube_worker[:name]}-#{i}"
        v.customize ["modifyvm", :id, "--memory", kube_worker[:mem]]
        v.customize ["modifyvm", :id, "--cpus", kube_worker[:cpu]]
      end
      worker.vm.provision "shell", path: "install-worker.sh"
    end
  end
end
