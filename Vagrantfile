VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "yungsang/coreos-alpha"  # latest coreos built (since default one is too outdated)

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.synced_folder ".", "/vagrant"
  config.vm.network "forwarded_port", guest: 8080, host:8080

  # as of Docker 1.3.2, --insecure-registry is required to access private registries without ssl
  config.vm.provision "shell", inline: "mkdir -p /etc/systemd/system/docker.service.d"
  config.vm.provision "shell", inline: "cat > /etc/systemd/system/docker.service.d/50-insecure-registry.conf <<EOF
[Service]
Environment=DOCKER_OPTS='--insecure-registry=\"0.0.0.0/0\"'
EOF"

  # the above config change requires a docker restart
  config.vm.provision "shell", inline: "systemctl daemon-reload"
  config.vm.provision "shell", inline: "systemctl restart docker"

end
