Vagrant.configure("2") do |config|
  (1..3).each do |i|
    config.vm.define "microk8s_#{i}" do |microk8s|
      microk8s.vm.box = "ubuntu/focal64"
      microk8s.vm.network "private_network", ip: "192.168.56.1#{i}", :name => 'vboxnet0', :adapter => 2
      microk8s.vm.provider "virtualbox" do |vb|
          vb.memory = 4096
          vb.cpus = 2
          vb.name = "microk8s-#{i}"
      end
      microk8s.vm.hostname = "microk8s-#{i}"
      microk8s.vm.provision "shell", inline: <<-EOF
        snap install microk8s --classic --channel=1.27
        snap install docker
        microk8s.status --wait-ready
        microk8s enable community

        sudo systemctl enable --now iscsid

        sudo sysctl -w vm.nr_hugepages=1024
        echo 'vm.nr_hugepages=1024' | sudo tee -a /etc/sysctl.conf
        sudo apt install -y linux-modules-extra-$(uname -r)
        sudo modprobe nvme_tcp
        echo 'nvme-tcp' | sudo tee -a /etc/modules-load.d/microk8s-mayastor.conf
        microk8s stop
        microk8s start
        microk8s.status --wait-ready

        usermod -a -G microk8s vagrant
        echo "alias kubectl='microk8s.kubectl'" > /home/vagrant/.bash_aliases
        echo "alias k='microk8s.kubectl'" >> /home/vagrant/.bash_aliases
        chown vagrant:vagrant /home/vagrant/.bash_aliases
        echo "alias kubectl='microk8s.kubectl'" > /root/.bash_aliases
        echo "alias k='microk8s.kubectl'" >> /root/.bash_aliases
        chown root:root /root/.bash_aliases

        sudo su -c 'echo "192.168.56.11 microk8s-1" >> /etc/hosts'
        sudo su -c 'echo "192.168.56.12 microk8s-2" >> /etc/hosts'
        sudo su -c 'echo "192.168.56.13 microk8s-3" >> /etc/hosts'
      EOF
      if i == 1
        microk8s.vm.provision "shell", inline: <<-EOF

          microk8s.add-node -l 3600 -t cfc1d5cdd49b30c81e72374a034d7bd2
          microk8s.enable dns
          microk8s.enable core/mayastor --default-pool-size 2G --skip-hugepages-check
          microk8s.enable metallb 192.168.56.100-192.168.56.110
          microk8s.enable ingress
          microk8s.enable helm
        EOF
      else
        microk8s.vm.provision "shell", inline: <<-EOF
          microk8s join 192.168.56.11:25000/cfc1d5cdd49b30c81e72374a034d7bd2
          microk8s.enable helm
        EOF
      end
    end
  end
end